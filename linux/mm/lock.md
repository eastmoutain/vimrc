# Introduction of mm

## mm->mmap_lock


## example in do_user_addr_fault
    mmap_read_lock(mm)  // semophore
        vma = find_vma(mm, address)
        handle_mm_fault() 
            __handle_mm_fault
                handle_pte_fault

