package com.spring.jwt.rest.demo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PersonDemoRestService {

    private static final List<PersonDemo> persons;

    static {
        persons = new ArrayList<>();
        persons.add(new PersonDemo("Hello", "World"));
        persons.add(new PersonDemo("Foo", "Bar"));
    }
    @RequestMapping(path = "/demo/persons", method = RequestMethod.GET)
    public static List<PersonDemo> getPersons() {
        return persons;
    }

    @RequestMapping(path = "/demo/persons/{name}", method = RequestMethod.GET)
    public static PersonDemo getPerson(@PathVariable("name") String name) {
        return persons.stream()
                .filter(person -> name.equalsIgnoreCase(person.getName()))
                .findAny().orElse(null);
    }
}
