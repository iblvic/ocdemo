//
//  Teacher.cpp
//  ocdemo
//
//  Created by haosimac on 2023/4/18.
//

#include "Teacher.hpp"

Teacher globalT;

Teacher::Teacher() {
    this->name = "lihua";
    this->age = 38;
}

Teacher::~Teacher() {
//    printf("~Teacher()\n");
}
