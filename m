From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 12 Aug 2017 01:29:06 +0800
Subject: [integrity:next-integrity-read 3/7] fs/efivarfs/file.c:100:9: error:
	implicit declaration of function 'simple_read_iter_from_buffer'
Message-ID: <201708120105.yipbvddb%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-read
head:   41c220b87122b621b88186b108b2cfd0fd7d71c2
commit: 3e7f7650643140c43341b6839a2e4cdc72e3c16a [3/7] efivarfs: replaces the read file operation with read_iter
config: i386-randconfig-x019-201732 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 3e7f7650643140c43341b6839a2e4cdc72e3c16a
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the integrity/next-integrity-read HEAD 41c220b87122b621b88186b108b2cfd0fd7d71c2 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   fs/efivarfs/file.c: In function 'efivarfs_file_read_iter':
>> fs/efivarfs/file.c:100:9: error: implicit declaration of function 'simple_read_iter_from_buffer' [-Werror=implicit-function-declaration]
     size = simple_read_iter_from_buffer(iocb, iter, data,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/init.h:4:0,
                    from include/linux/efi.h:14,
                    from fs/efivarfs/file.c:10:
   fs/efivarfs/file.c: At top level:
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'strcpy' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:390:2: note: in expansion of macro 'if'
     if (p_size == (size_t)-1 && q_size == (size_t)-1)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:380:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'kmemdup' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:378:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:369:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr_inv' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:367:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:358:2: note: in expansion of macro 'if'
     if (p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memchr' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:356:2: note: in expansion of macro 'if'
     if (__builtin_constant_p(size) && p_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:348:2: note: in expansion of macro 'if'
     if (p_size < size || q_size < size)
     ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:345:3: note: in expansion of macro 'if'
      if (q_size < size)
      ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'
    #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
                          ^~~~~~~~~~
   include/linux/string.h:343:3: note: in expansion of macro 'if'
      if (p_size < size)
      ^~
   include/linux/compiler.h:162:4: warning: '______f' is static but declared in inline function 'memcmp' which is not static
       ______f = {     \
       ^
   include/linux/compiler.h:154:23: note: in expansion of macro '__trace_if'

vim +/simple_read_iter_from_buffer +100 fs/efivarfs/file.c

    66	
    67	static ssize_t efivarfs_file_read_iter(struct kiocb *iocb,
    68					       struct iov_iter *iter)
    69	{
    70		struct file *file = iocb->ki_filp;
    71		struct efivar_entry *var = file->private_data;
    72		unsigned long datasize = 0;
    73		u32 attributes;
    74		void *data;
    75		ssize_t size = 0;
    76		int err;
    77	
    78		err = efivar_entry_size(var, &datasize);
    79	
    80		/*
    81		 * efivarfs represents uncommitted variables with
    82		 * zero-length files. Reading them should return EOF.
    83		 */
    84		if (err == -ENOENT)
    85			return 0;
    86		else if (err)
    87			return err;
    88	
    89		data = kmalloc(datasize + sizeof(attributes), GFP_KERNEL);
    90	
    91		if (!data)
    92			return -ENOMEM;
    93	
    94		size = efivar_entry_get(var, &attributes, &datasize,
    95					data + sizeof(attributes));
    96		if (size)
    97			goto out_free;
    98	
    99		memcpy(data, &attributes, sizeof(attributes));
 > 100		size = simple_read_iter_from_buffer(iocb, iter, data,
   101						    datasize + sizeof(attributes));
   102	out_free:
   103		kfree(data);
   104	
   105		return size;
   106	}
   107	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
