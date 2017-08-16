From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Wed, 16 Aug 2017 14:38:10 -0400
Subject: [integrity:next-log-iversion 9/11] include/linux/ima.h:70:20:
	warning: 'ima_sb_post_new_mount' used but never defined
In-Reply-To: <201708170127.b1ajiWwb%fengguang.wu@intel.com>
References: <201708170127.b1ajiWwb%fengguang.wu@intel.com>
Message-ID: <1502908690.21278.5.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-08-17 at 01:58 +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-log-iversion
> head:   5873cd8f629e0306acdc40d3a9142eb50ae70c2d
> commit: 58015ce0b48226300bb6805a75c99cf538a524c6 [9/11] ima: define new ima_sb_post_new_mount hook
> config: x86_64-randconfig-x007-201733 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 58015ce0b48226300bb6805a75c99cf538a524c6
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from security/security.c:22:0:
>    include/linux/ima.h:72:1: error: expected identifier or '(' before '{' token
>     { }
>     ^
>    In file included from security/security.c:22:0:
> >> include/linux/ima.h:70:20: warning: 'ima_sb_post_new_mount' used but never defined
>     static inline void ima_sb_post_new_mount(const struct vfsmount *newmnt,
>                        ^~~~~~~~~~~~~~~~~~~~~
> 
> vim +/ima_sb_post_new_mount +70 include/linux/ima.h
> 
>     69	
>   > 70	static inline void ima_sb_post_new_mount(const struct vfsmount *newmnt,
>     71						 const struct path *path);

It looks like the mistaken trailing semicolon cause this and the rest
of the errors.

Mimi

>   > 72	{ }
>     73	#endif /* CONFIG_IMA */
>     74	
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
