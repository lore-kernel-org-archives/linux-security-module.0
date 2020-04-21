Return-Path: <SRS0=3gqt=6F=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C47EC54FD0
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Apr 2020 16:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBEF206F4
	for <linux-security-module@archiver.kernel.org>; Tue, 21 Apr 2020 16:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QO5wETf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgDUQRy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728524AbgDUQRy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 21 Apr 2020 12:17:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3665EC061A10;
        Tue, 21 Apr 2020 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=xqmg0An1FNm71Rn8CNfNjVeNbARH52V7+uUJSia2F1E=; b=QO5wETf640vmg1TGBpVIK9KArR
        wBmPuTp0JgLWPT7QDLETGnh2c/CxiLWCC0PKuu2QY4PdRRBnt3GXXgl7h75IlT2HHZFeboOEOzJlO
        2gXZh5hm8/h3bULCwrvcVRjhtkjblgbqkc7jFYqY8M269ov9pKK6TCf4H19FY8mVa6nHtcTyNHGbr
        5u8SfS3gHJNeUqPylQyfR0IuijXnXOZBWMxK2WRC+JEAA+BFGAjx+fjWrccieZWxNNTnaX8sVFbAZ
        ZvTjaANkzedCt+5k+JM6JXAfYO1RpoZUHc7/lA579jj3lWNjSFi1gpe8dOzCG8qrXHd866i4bIgea
        xwAEhEfg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQvan-00035M-V7; Tue, 21 Apr 2020 16:17:50 +0000
Subject: Re: [PATCH RFC] Documentation: LSM: Correct the basic LSM description
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org,
        James Morris <jmorris@namei.org>
References: <3d5970b8-f95a-2f15-851a-472cbceb94d4.ref@schaufler-ca.com>
 <3d5970b8-f95a-2f15-851a-472cbceb94d4@schaufler-ca.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <073a23d4-3f2f-5e76-a3c4-567d7302a44a@infradead.org>
Date:   Tue, 21 Apr 2020 09:17:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3d5970b8-f95a-2f15-851a-472cbceb94d4@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Casey,

I have a few small comments:

On 4/20/20 5:02 PM, Casey Schaufler wrote:
> This is a first pass at updating the basic documentation on
> Linux Security Modules (LSM), which is frighteningly out of date.
> Remove untrue statements about the LSM framework. Replace them
> with true statements where it is convenient to do so. This is
> the beginning of a larger effort to bring the LSM documentation
> up to date.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  Documentation/security/lsm.rst | 204 ++++++++++++++---------------------------
>  1 file changed, 68 insertions(+), 136 deletions(-)
> 
> diff --git a/Documentation/security/lsm.rst b/Documentation/security/lsm.rst
> index ad4dfd020e0d..21df075882e6 100644
> --- a/Documentation/security/lsm.rst
> +++ b/Documentation/security/lsm.rst
> @@ -35,47 +35,50 @@ desired model of security. Linus also suggested the possibility of
>  migrating the Linux capabilities code into such a module.
>  
>  The Linux Security Modules (LSM) project was started by WireX to develop
> -such a framework. LSM is a joint development effort by several security
> +such a framework. LSM was a joint development effort by several security
>  projects, including Immunix, SELinux, SGI and Janus, and several
>  individuals, including Greg Kroah-Hartman and James Morris, to develop a
> -Linux kernel patch that implements this framework. The patch is
> -currently tracking the 2.4 series and is targeted for integration into
> -the 2.5 development series. This technical report provides an overview
> -of the framework and the example capabilities security module provided
> -by the LSM kernel patch.
> +Linux kernel patch that implements this framework. The work was
> +incorporated in the mainstream in December of 2003. This technical
> +report provides an overview of the framework and the capabilities
> +security module.
>  
>  LSM Framework
>  =============
>  
> -The LSM kernel patch provides a general kernel framework to support
> +The LSM framework provides a general kernel framework to support
>  security modules. In particular, the LSM framework is primarily focused
>  on supporting access control modules, although future development is
> -likely to address other security needs such as auditing. By itself, the
> +likely to address other security needs such as sandboxing. By itself, the
>  framework does not provide any additional security; it merely provides
> -the infrastructure to support security modules. The LSM kernel patch
> -also moves most of the capabilities logic into an optional security
> -module, with the system defaulting to the traditional superuser logic.
> +the infrastructure to support security modules. The LSM framework is
> +optional, requiring `CONFIG_SECURITY` to be enabled. The capabilities
> +logic is implemented as a security module.
>  This capabilities module is discussed further in
>  `LSM Capabilities Module <#cap>`__.
>  
> -The LSM kernel patch adds security fields to kernel data structures and
> -inserts calls to hook functions at critical points in the kernel code to
> -manage the security fields and to perform access control. It also adds
> -functions for registering and unregistering security modules, and adds a
> -general :c:func:`security()` system call to support new system calls
> -for security-aware applications.
> -
> -The LSM security fields are simply ``void*`` pointers. For process and
> -program execution security information, security fields were added to
> +The LSM framework includes security fields in kernel data structures and
> +calls to hook functions at critical points in the kernel code to
> +manage the security fields and to perform access control.
> +It also adds functions for registering security modules.
> +An interface `/sys/kernel/security/lsm` reports a comma separated list
> +of security modules that are active on the system.
> +
> +The LSM security fields are simply ``void*`` pointers.
> +The data is referred to as a blob, which may be managed by
> +the framework or by the individual security modules that use it.
> +Security blobs that are used by more than one security module are
> +typically managed by the framework.
> +For process and
> +program execution security information, security fields are included in
>  :c:type:`struct task_struct <task_struct>` and
> -:c:type:`struct linux_binprm <linux_binprm>`. For filesystem
> -security information, a security field was added to :c:type:`struct
> +:c:type:`struct cred <cred>`.
> +For filesystem
> +security information, a security field is included in :c:type:`struct
>  super_block <super_block>`. For pipe, file, and socket security
> -information, security fields were added to :c:type:`struct inode
> -<inode>` and :c:type:`struct file <file>`. For packet and
> -network device security information, security fields were added to
> -:c:type:`struct sk_buff <sk_buff>` and :c:type:`struct
> -net_device <net_device>`. For System V IPC security information,
> +information, security fields are included in :c:type:`struct inode
> +<inode>` and :c:type:`struct file <file>`.
> +For System V IPC security information,
>  security fields were added to :c:type:`struct kern_ipc_perm
>  <kern_ipc_perm>` and :c:type:`struct msg_msg
>  <msg_msg>`; additionally, the definitions for :c:type:`struct
> @@ -84,118 +87,47 @@ were moved to header files (``include/linux/msg.h`` and
>  ``include/linux/shm.h`` as appropriate) to allow the security modules to
>  use these definitions.
>  
> -Each LSM hook is a function pointer in a global table, security_ops.
> -This table is a :c:type:`struct security_operations
> -<security_operations>` structure as defined by
> -``include/linux/security.h``. Detailed documentation for each hook is
> -included in this header file. At present, this structure consists of a
> -collection of substructures that group related hooks based on the kernel
> -object (e.g. task, inode, file, sk_buff, etc) as well as some top-level
> -hook function pointers for system operations. This structure is likely
> -to be flattened in the future for performance. The placement of the hook
> -calls in the kernel code is described by the "called:" lines in the
> -per-hook documentation in the header file. The hook calls can also be
> -easily found in the kernel code by looking for the string
> -"security_ops->".
> -
> -Linus mentioned per-process security hooks in his original remarks as a
> -possible alternative to global security hooks. However, if LSM were to
> -start from the perspective of per-process hooks, then the base framework
> -would have to deal with how to handle operations that involve multiple
> -processes (e.g. kill), since each process might have its own hook for
> -controlling the operation. This would require a general mechanism for
> -composing hooks in the base framework. Additionally, LSM would still
> -need global hooks for operations that have no process context (e.g.
> -network input operations). Consequently, LSM provides global security
> -hooks, but a security module is free to implement per-process hooks
> -(where that makes sense) by storing a security_ops table in each
> -process' security field and then invoking these per-process hooks from
> -the global hooks. The problem of composition is thus deferred to the
> -module.
> -
> -The global security_ops table is initialized to a set of hook functions
> -provided by a dummy security module that provides traditional superuser
> -logic. A :c:func:`register_security()` function (in
> -``security/security.c``) is provided to allow a security module to set
> -security_ops to refer to its own hook functions, and an
> -:c:func:`unregister_security()` function is provided to revert
> -security_ops to the dummy module hooks. This mechanism is used to set
> -the primary security module, which is responsible for making the final
> -decision for each hook.
> -
> -LSM also provides a simple mechanism for stacking additional security
> -modules with the primary security module. It defines
> -:c:func:`register_security()` and
> -:c:func:`unregister_security()` hooks in the :c:type:`struct
> -security_operations <security_operations>` structure and
> -provides :c:func:`mod_reg_security()` and
> -:c:func:`mod_unreg_security()` functions that invoke these hooks
> -after performing some sanity checking. A security module can call these
> -functions in order to stack with other modules. However, the actual
> -details of how this stacking is handled are deferred to the module,
> -which can implement these hooks in any way it wishes (including always
> -returning an error if it does not wish to support stacking). In this
> -manner, LSM again defers the problem of composition to the module.
> -
> -Although the LSM hooks are organized into substructures based on kernel
> -object, all of the hooks can be viewed as falling into two major
> +For packet and
> +network device security information, security fields were added to
> +:c:type:`struct sk_buff <sk_buff>` and
> +:c:type:`struct scm_cookie <scm_cookie>`.
> +Unlike the other security module data, the data used here is a
> +32 bit integer. The secuirty modules are required to map or otherwise

   32-bit              security

> +associate these values with real security attributes.
> +
> +LSM hooks are maintained in lists. A list is maintained for each
> +hook, and the hooks are called in the order specified by CONFIG_LSM.
> +Detailed documentation for each hook is
> +included in the `include/linux/lsm_hooks.h` header file.
> +
> +The LSM framework provides for a close approximation of
> +general security module stacking. It defines
> +:c:func:`security_add_hooks()` to which each security module passes a
> +:c:type:`struct security_hooks_list <security_hooks_list>`,
> +which are added to the lists.
> +The LSM framework does not provide a mechanism for removing hooks that
> +have been registered. An individual security module chose to implement

                                                       may choose

> +such a mechanism, but the safety of such a mechanism is in no way
> +guaranteed by the framework.
> +
> +The hooks can be viewed as falling into two major
>  categories: hooks that are used to manage the security fields and hooks
>  that are used to perform access control. Examples of the first category
> -of hooks include the :c:func:`alloc_security()` and
> -:c:func:`free_security()` hooks defined for each kernel data
> -structure that has a security field. These hooks are used to allocate
> -and free security structures for kernel objects. The first category of
> -hooks also includes hooks that set information in the security field
> -after allocation, such as the :c:func:`post_lookup()` hook in
> -:c:type:`struct inode_security_ops <inode_security_ops>`.
> -This hook is used to set security information for inodes after
> -successful lookup operations. An example of the second category of hooks
> -is the :c:func:`permission()` hook in :c:type:`struct
> -inode_security_ops <inode_security_ops>`. This hook checks
> -permission when accessing an inode.
> +of hooks include the :c:func:`security_inode_alloc()` and
> +:c:func:`security_inode_free()`
> +These hooks are used to allocate
> +and free security structures for inode objects.
> +An example of the second category of hooks
> +is the :c:func:`security_inode_permission()` hook.
> +This hook checks permission when accessing an inode.
>  
>  LSM Capabilities Module
>  =======================
>  
> -The LSM kernel patch moves most of the existing POSIX.1e capabilities
> -logic into an optional security module stored in the file
> -``security/capability.c``. This change allows users who do not want to
> -use capabilities to omit this code entirely from their kernel, instead
> -using the dummy module for traditional superuser logic or any other
> -module that they desire. This change also allows the developers of the
> -capabilities logic to maintain and enhance their code more freely,
> -without needing to integrate patches back into the base kernel.
> -
> -In addition to moving the capabilities logic, the LSM kernel patch could
> -move the capability-related fields from the kernel data structures into
> -the new security fields managed by the security modules. However, at
> -present, the LSM kernel patch leaves the capability fields in the kernel
> -data structures. In his original remarks, Linus suggested that this
> -might be preferable so that other security modules can be easily stacked
> -with the capabilities module without needing to chain multiple security
> -structures on the security field. It also avoids imposing extra overhead
> -on the capabilities module to manage the security fields. However, the
> -LSM framework could certainly support such a move if it is determined to
> -be desirable, with only a few additional changes described below.
> -
> -At present, the capabilities logic for computing process capabilities on
> -:c:func:`execve()` and :c:func:`set\*uid()`, checking
> -capabilities for a particular process, saving and checking capabilities
> -for netlink messages, and handling the :c:func:`capget()` and
> -:c:func:`capset()` system calls have been moved into the
> -capabilities module. There are still a few locations in the base kernel
> -where capability-related fields are directly examined or modified, but
> -the current version of the LSM patch does allow a security module to
> -completely replace the assignment and testing of capabilities. These few
> -locations would need to be changed if the capability-related fields were
> -moved into the security field. The following is a list of known
> -locations that still perform such direct examination or modification of
> -capability-related fields:
> -
> --  ``fs/open.c``::c:func:`sys_access()`
> -
> --  ``fs/lockd/host.c``::c:func:`nlm_bind_host()`
> -
> --  ``fs/nfsd/auth.c``::c:func:`nfsd_setuser()`
> -
> --  ``fs/proc/array.c``::c:func:`task_cap()`
> +The POSIX.1e capabilities logic is maintained as a security module
> +stored in the file ``security/commoncap.c``. The capabilities
> +module uses the order field of the :c:type:`lsm_info` description
> +to identify it as the first security module to be registered.
> +The capabilities security module does not use the general security
> +blobs, unlike other modules. The reasons are historical and are
> +based on overhead, complexity and performance concerns.
> 
> 

Thanks for updating this.
-- 
~Randy

