//Mark White
//CSD430
//Assignment 2 - JavaBean Class

package bean;

import java.io.Serializable;

/**
* JavaBean to represent a movie fact record.
*/
public class MovieFact implements Serializable {
 private String category;
 private String description;
 private String detail;

 // No-arg constructor (required for JavaBeans)
 public MovieFact() {}

 // Parameterized constructor
 public MovieFact(String category, String description, String detail) {
     this.category = category;
     this.description = description;
     this.detail = detail;
 }

 // Getters and Setters
 public String getCategory() {
     return category;
 }

 public void setCategory(String category) {
     this.category = category;
 }

 public String getDescription() {
     return description;
 }

 public void setDescription(String description) {
     this.description = description;
 }

 public String getDetail() {
     return detail;
 }

 public void setDetail(String detail) {
     this.detail = detail;
 }
}
