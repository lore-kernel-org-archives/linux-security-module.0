From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Tue, 30 Jan 2018 15:57:58 +0200
Subject: [LSF/MM TOPIC] Protectable Dynamically allocated Memory for both
	kernel and userspace
Message-ID: <c6c462fe-4aa1-3922-725d-03c3b1da0786@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

At the LSF/MM summit, I would like to discuss the following topics:

- Dynamic allocation of protectable (read/only) memory in kernel space
- Rare Write option for the aforementioned dynamic allocation
  (this is most likely related to Kees Cook's rare-write proposal)
- Support for userspace to mprotect selected pages:
   * as permanently R/O
   * as rare write
    (this might be easier to implement than kernel rare-write)
   Probably both of these will also require a separate userspace memory
   allocator, which understands pools, or at the very least, can support
   different types of pages.
- Optimization of vmalloc (combining vmap_area and vm_struct structures)

--
igor stoppa

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
