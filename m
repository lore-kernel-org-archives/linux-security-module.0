Return-Path: <SRS0=XO9p=ND=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F11C46475
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA1C20813
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Oct 2018 21:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIMhf+le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA1C20813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeJXGBM (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 24 Oct 2018 02:01:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46940 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeJXGBM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Oct 2018 02:01:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id x3-v6so2783169lji.13;
        Tue, 23 Oct 2018 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to;
        bh=EvfJxrXks7BXh1WhlCSD8GlGCHbF3dfEcNLAYyx3uWU=;
        b=XIMhf+leFdNLMAPB8KQ5fBNDZe4l7YhyPYpQ6DrtnnGpSlXZYULKRX9rjUkqKisJzh
         ZYAE3wDVlDMfKoU5hFsQ3PF+mik6B89cKr0xOFLoce+b+gvySo9OLtxPlRPAZqRsAPX2
         JCITc0BG1EAdZYkwsHwixyMsXz4TX4NKhX/dY6vMTLmzV4nPbkdUqa2gZIXE2Ks3kMha
         FoH77yFIMx77a2DFaZqbVysMNLRmMG1J1ikCFRbP2LxJ8A0f4NsztMLRnu36lIH1UFqV
         Nff9jVt7a+Wy42LtptF83oXSYsrLYPkwwlRO4Q5KPqqYmaG/cvcJhJQwYlGxhFHVr/Ts
         2e2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvfJxrXks7BXh1WhlCSD8GlGCHbF3dfEcNLAYyx3uWU=;
        b=P7r7v9sPd2sPYS6tMEZuvuUFODeUFA7UuaClFksuL7+QYCDaKXn+e4I2e5j1+oYMmS
         0YgZw0cRs1gNEXmWB+UcPazHKPpEDw3VDSMtgs+eHYIm5K0VOUea8QLlMTFtHsaoDsr5
         yTE95hv4nEML8t3nKOOkW4/NnmrNYpbkzDTqaiPDI35fcgxmYiELrWubrsgzCxXmgOhs
         JUr5tMNngzIYrD2uIv+cQIYsIynAmHwMAPjSfriq/gjWyHbDXolAyjEdO/+zQ23EAkaz
         2QdmOV6qixA9vaQRpwS3EwjDdQOyVqyS4hXTOFEdl2p3Yiw8tDWinyRJWnVDdUr8PpC5
         2FBw==
X-Gm-Message-State: ABuFfohHN7fC1SqoQRAwA8Di0bhu85eTAcserE9fIv7RRvzCW2135XFf
        Y0Dz5EtalnPHgF+UZIlV9S8=
X-Google-Smtp-Source: ACcGV63CK4GMH9B5QBdL2TZZ1eFF29juThMSspV3PKOLTUFwCVxVI2panE+WVoC1oj6lA0vBJ5bF6w==
X-Received: by 2002:a2e:8347:: with SMTP id l7-v6mr23798894ljh.140.1540330556820;
        Tue, 23 Oct 2018 14:35:56 -0700 (PDT)
Received: from localhost.localdomain (91-159-62-169.elisa-laajakaista.fi. [91.159.62.169])
        by smtp.gmail.com with ESMTPSA id y127-v6sm377950lfc.13.2018.10.23.14.35.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 14:35:55 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     igor.stoppa@huawei.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>
Subject: [RFC v1 PATCH 00/17] prmem: protected memory
Date:   Wed, 24 Oct 2018 00:34:47 +0300
Message-Id: <20181023213504.28905-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Reply-To: Igor Stoppa <igor.stoppa@gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

-- Summary --

Preliminary version of memory protection patchset, including a sample use
case, turning into write-rare the IMA measurement list.

The core idea is to introduce two new types of memory protection, beside
const and __ro_after_init, which will support:
- statically allocated "write rare" memory
- dynamically allocated "read only" and "write rare" memory

On top of that, follows a set of patches which create a "write rare"
counterpart of the kernel infrastructure used in the example chose for
hardening: the IMA measurement list.

-- Mechanism --

Statically allocated protected memory is identified by the __wr_after_init
tag, which will cause the linker to place it in a special section.

Dynamically allocated memory is obtained through vmalloc, but compacting
each allocation, where possible, in the latest obtained vmap_area.

The write rare mechanism is implemented by creating a temporary alternate
writable mapping, applying the change through this mapping and then
removing it.

All of this is possible thanks to the system MMU, which must be able to
provide write protection.

-- Brief history --

I sent out various versions of memory protection over the last year or so,
however this patchset is significantly expanded, including several helper
data structures and a use case, so I decided to reset the numbering to v1.

As reference, the latest "old" version is here [1].

The current version is not yet ready for merge, however it is sufficiently
complete for supporting an end-to-end discussion, I think.

Eventually, I plan to write a white paper, once the code is in better shape.
In the meanwhile, an overview can be had from these slides [2], which are
the support material for my presentation at the Linux Security Summit 2018
Europe.

-- Validation --

Most of the testing is done on a Fedora image, with QEMU x86_64,
however the code has been also tested on a real x86_64 PC, yielding
similar positive results.
For ARM64, I use a custom Debian installation, still with QEMU, but I have
obtained similar failures when testing with a real device, using a
Kirin970.

I have written some test cases for the most basic parts and the behaviour
of IMA and the Fedora image in general do not seem to be negatively
affected, when used in conjunction with this patchset.
However, it's far from being exhaustive testing and the torture test for
rcu is completely missing.

-- Known Issues --

As said, this version is preliminary and certain parts need rework.
This is a short and incomplete list of known issues:

* arm64 support is broken for __wr_after_init
  I must create a separate section with proper mappings, similar to the
  ones used for vmalloc()

* alignment of data structures has not been throughly checked
  There are probably several redundant forced alignments

* there is no fallback for platforms missing MMU write protection

* some additional care might be needed when dealing with double mapping vs
  data cache coherency, on multicore systems

* lots of additional (stress) tests are needed

* memory reuse (object caches) are probably needed, to support converting
  more use cases, and so also other data structures.

* credits for original code: I have reimplemented various data structures,
  I am not sure if I have given credit correctly to the original authors.

* documentation for the re-implemented data structures is missing

* confirm that the hardened usercopy logic is correct

-- Q&As --

During reviews of the older patchset, several objections and questions
were formulated.

They are collected here in Q&A format, with both some old and new answers:

1 - "The protection can still be undone"
Yes, it is true. Using a hypervisor, like it is done in certain Huawei and
Samsung phones, provides a better level of protection.
However, even without that, it still gives a significantly better level of
protection than not protecting the memory at all.
The main advantage of this patchset is that now the attack has to focus on
the page table, which is a significantly smaller area, than the whole
kernel data.
It is my intention, eventually, to provide also support for interaction
with a FOSS hypervisor (ex: KVM), but this patchset should
support also those cases where it's not even possible to have an hypervisor.
So it seems simpler to start from there. The hypervisor is not mandatory.


2 - "Do not provide a chain of trust, but protect some memory and refer to
it with a writable pointer."
This might be ok for protecting against bugs, but in the case of an
attacker trying to compromise the system, the unprotected pointer has
become the new target. It doesn't change much.
Samsung does use a similar implementation, for protecting LSM hooks,
however that solution also add a pointer, from the protected memory back
to the writable memory, as validation loop. And the price to pay is that
every time the unprotected pointer must be used, it first has to be
validated, to point to a certain memory range and to have a specific
alignment. It's an alternative solution to the full chain of trust and
each has its specific advantages, depending on the data structures that
one wants to protect.


3 - "Do not use a secondary mapping, unprotect the current one"
The purpose of the secondary mapping is to create a hard-to-spot window of
writability at a random address, which cannot be easily exploited.
Unprotecting the primary mapping would allow an attack where a core is
busy looping trying to figure out if a specific location becomes writable
and race against the legitimate writer. For the same reason, interrupts
are disabled on the core that is performing the write-rare operation.


4 - "Do not create another allocator over vmalloc(), use it plain"
This is not good for various reasons:
a) vmalloc() allocates at least one page for every request it receives,
leaving most of the page typically unused. While it might not be a big
deal on large systems, on IoT class devices it is possible to find
relatively powerful cores paired to relatively little memory.
Taking as example a system using SELinux, a relatively small set of rules
can genarate a few thousands of allocations (SELinux is deny-by-default).
Modeling each allocation to be about 64bytes, on a system with 4kB pages,
assuming that the grand total of allocation is 100k, that means
                 100k * 4kB = 390MB
while, using each 64bytes slot in a page yields:
                 100k * 64B = 6MB
The first case would not be very compatible with a system having only
512MB or 1GB.
b) even worse, the amount of thrashing of the TLB would be terrible, with
each allocation having its own translation.

--

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>


-- References --

[1]: https://lkml.org/lkml/2018/4/23/508
[2]: https://events.linuxfoundation.org/wp-content/uploads/2017/12/Kernel-Hardening-Protecting-the-Protection-Mechanisms-Igor-Stoppa-Huawei.pdf

-- List of patches --

[PATCH 01/17] prmem: linker section for static write rare
[PATCH 02/17] prmem: write rare for static allocation
[PATCH 03/17] prmem: vmalloc support for dynamic allocation
[PATCH 04/17] prmem: dynamic allocation
[PATCH 05/17] prmem: shorthands for write rare on common types
[PATCH 06/17] prmem: test cases for memory protection
[PATCH 07/17] prmem: lkdtm tests for memory protection
[PATCH 08/17] prmem: struct page: track vmap_area
[PATCH 09/17] prmem: hardened usercopy
[PATCH 10/17] prmem: documentation
[PATCH 11/17] prmem: llist: use designated initializer
[PATCH 12/17] prmem: linked list: set alignment
[PATCH 13/17] prmem: linked list: disable layout randomization
[PATCH 14/17] prmem: llist, hlist, both plain and rcu
[PATCH 15/17] prmem: test cases for prlist and prhlist
[PATCH 16/17] prmem: pratomic-long
[PATCH 17/17] prmem: ima: turn the measurements list write rare

-- Diffstat --

 Documentation/core-api/index.rst          |   1 +
 Documentation/core-api/prmem.rst          | 172 +++++
 MAINTAINERS                               |  14 +
 drivers/misc/lkdtm/core.c                 |  13 +
 drivers/misc/lkdtm/lkdtm.h                |  13 +
 drivers/misc/lkdtm/perms.c                | 248 +++++++
 include/asm-generic/vmlinux.lds.h         |  20 +
 include/linux/cache.h                     |  17 +
 include/linux/list.h                      |   5 +-
 include/linux/mm_types.h                  |  25 +-
 include/linux/pratomic-long.h             |  73 ++
 include/linux/prlist.h                    | 934 ++++++++++++++++++++++++
 include/linux/prmem.h                     | 446 +++++++++++
 include/linux/prmemextra.h                | 133 ++++
 include/linux/types.h                     |  20 +-
 include/linux/vmalloc.h                   |  11 +-
 lib/Kconfig.debug                         |   9 +
 lib/Makefile                              |   1 +
 lib/test_prlist.c                         | 252 +++++++
 mm/Kconfig                                |   6 +
 mm/Kconfig.debug                          |   9 +
 mm/Makefile                               |   2 +
 mm/prmem.c                                | 273 +++++++
 mm/test_pmalloc.c                         | 629 ++++++++++++++++
 mm/test_write_rare.c                      | 236 ++++++
 mm/usercopy.c                             |   5 +
 mm/vmalloc.c                              |   7 +
 security/integrity/ima/ima.h              |  18 +-
 security/integrity/ima/ima_api.c          |  29 +-
 security/integrity/ima/ima_fs.c           |  12 +-
 security/integrity/ima/ima_main.c         |   6 +
 security/integrity/ima/ima_queue.c        |  28 +-
 security/integrity/ima/ima_template.c     |  14 +-
 security/integrity/ima/ima_template_lib.c |  14 +-
 34 files changed, 3635 insertions(+), 60 deletions(-)

