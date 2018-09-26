From: ztong@vt.edu (TongZhang)
Date: Tue, 25 Sep 2018 20:47:54 -0400
Subject: Naming confusion and code comments for
	security_kernel_(post_)read_file
Message-ID: <208C9D5E-E63B-4A89-BC91-E163CF52AD03@vt.edu>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

When we were doing code review, we found and feel that the current name and 
description of security_kernel_read_file and security_kernel_post_read_file, 
and corresponding document/code comment in include/linux/lsm_hooks.h is
confusing and kind of misleading as we discovered that security_kernel_(post_)read_file and kernel_read() do not always in appear in pair.

security_kerne(post_)read_file is only interested in checking firmware/kernel module/policy file etc, however, kernel_read() are used in other places in which the parameters are also specified by userspace. For example, kernel_read() is used in https://elixir.bootlin.com/linux/latest/source/arch/x86/ia32/ia32_aout.c#L413

We suggest that it might be better to fixing the code comment as well as 
the function naming and it may help clarify the purpose of this LSM hook function.

- Tong
