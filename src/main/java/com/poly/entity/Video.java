package com.poly.entity;

import jakarta.persistence.*;
import lombok.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "Video")
@Data @NoArgsConstructor @AllArgsConstructor
public class Video {
    @Id
    @Column(name = "Id")
    private String id;

    @Column(name = "Title")
    private String title;

    @Column(name = "Poster")
    private String poster;

    @Column(name = "Views")
    private int views = 0;

    @Column(name = "Description")
    private String description;

    @Column(name = "Active")
    private boolean active = true;

    @OneToMany(mappedBy = "video")
    private List<Favorite> favorites;
}
