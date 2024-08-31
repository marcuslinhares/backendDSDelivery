package com.devsuperior.dsdeliver.services;

import com.devsuperior.dsdeliver.dto.ProductDTO;
import com.devsuperior.dsdeliver.model.Product;
import com.devsuperior.dsdeliver.repositories.ProductRepository;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductRepository repository;

    @Transactional(readOnly = true)
    public List<ProductDTO> findAll(){
        List<Product> list = repository.findAllByOrderByNameAsc();
        return list.stream().map(ProductDTO::new).collect(Collectors.toList());
    }
}
