package main

import (
	"errors"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

var r *mux.Router

func main() {
	err := setup()
	if err != nil {
		log.Fatal("Failed setup: ", err)
	}

	http.ListenAndServe(":8080", r)
}

func UserHandler(w http.ResponseWriter, r *http.Request) {
	id, err := strconv.Atoi(mux.Vars(r)["id"])
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	log.Print("Go service: user requested: " + strconv.Itoa(id))

	user, err := findUser(id)

	if err != nil {
		if err.Error() == "Not found" {
			w.WriteHeader(http.StatusNotFound)
			return
		}
		w.WriteHeader(http.StatusInternalServerError)
		return
	}
	fmt.Fprintf(w, user)
}

func AllUsersHandler(w http.ResponseWriter, r *http.Request) {
	log.Print("Go service: returning all users")
	fmt.Fprintf(w, "[{\"name\": \"foo\", \"id\": 1}]")
}

func findUser(id int) (string, error) {
	if id != 1 {
		return "", errors.New("Not found")
	}
	return `{"name": "foo", "id": 1}`, nil
}

func setup() error {
	log.Print("Go service starting up")

	r = mux.NewRouter()
	r.HandleFunc("/v1/users/{id}", UserHandler)
	r.HandleFunc("/v1/users/", AllUsersHandler)
	http.Handle("/", r)

	return nil
}
