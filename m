Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7FEC636CD
	for <linux-security-module@archiver.kernel.org>; Sat,  4 Feb 2023 05:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjBDFct (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 4 Feb 2023 00:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjBDFcs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 4 Feb 2023 00:32:48 -0500
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5146C93E14
        for <linux-security-module@vger.kernel.org>; Fri,  3 Feb 2023 21:32:45 -0800 (PST)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 31459tBX011607;
        Fri, 3 Feb 2023 23:09:55 -0600
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 31459sjA011605;
        Fri, 3 Feb 2023 23:09:54 -0600
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 00/14] Implement Trusted Security Event Modeling.
Date:   Fri,  3 Feb 2023 23:09:40 -0600
Message-Id: <20230204050954.11583-1-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch series implements Trusted Security Event Modeling (TSEM) as
a new Linux Security Module (LSM) architecture.

At a conceptual level, TSEM can be thought of as an integration of
integrity measurement and mandatory access controls.  TSEM brings to
Linux security, a new model for implementing security controls that is
unique among current operating system platforms.

TSEM is designed to support the concept of a Trust Orchestration
System (TOS).  Trust orchestration involves the process of modeling
the security behavior of a workload, or a platform at large, and
defining whether or not a process is to be trusted, based on whether
or not the security events that it produces are consistent with a
security model that has been designed for a workload or platform.

TSEM operates under the premise, that security, like all other
physical phenomena in science and engineering, can be mathematically
modeled.  TSEM notionally treats the LSM security event hooks as a
basis set that is capable of generating a functional value for a
security model.

To support this notion, TSEM implements, entirely within the context
of the LSM architecture, the notion of security modeling domains which
are akin to resource namespaces.  A modeling domain is designed to be
paired with a Trusted Modeling Agent (TMA) that implements the root of
trust for a security domain/namespace.

A TMA implementation uses the descriptive parameters of a security
event hook to compute task specific coefficients for each security
event that occurs in a modeling domain.  The sum of these
coefficients, represents the security 'state' of the model.  These
coefficients, nee state points, for a security model are designed to
be developed by unit testing of an application stack.

TSEM thus represents a security architecture designed to support
modern software development strategies that are embracing
resource containerization and continuous integration and
development practices.  The objective of TSEM, along with
Quixote, it's userspace TOS implementation, is to bring to Linux
integrity and mandatory what Docker brought to Linux resource
namespaces.

The Quixote TOS has implementations of trust orchestrator's for the
following TMA trust roots:

Kernel.

Userspace process.

SGX enclave.

Xen Hypervisor domain.

Hardware based security coprocessors.

One of the objectives for Quixote/TSEM is to provide a framework for
developing next generation security co-processor technology that
extends beyond what is currently represented in the form of Trusted
Platform Modules.

Included with the Quixote TOS is an implementation of a security
co-processor based on the Nordic NRF52840-DONGLE micro-controller.
This is a USB form factor device that is currently being used for
projects such as GOOGLE's OpenSK security key initiative and 3mdeb's
Fobnail attestation server project.

Included in the patch series is an extensive documentation file that
can be found in the following location after the series is applied:

Documentation/admin-guide/LSM/tsem.rst

Reviewers, and other who are interested, are referred to this
document for a more extensive discussion into the rationale,
design and implementation of the TSEM architecture.

Control of TSEM is surfaced entirely through the tsemfs filesystem
that has the following mountpoint:

/sys/fs/tsem

TSEM is designed to be largely self-contained and independent of the
kernel at large and other LSM's.  It operates without the need for
filesystem labeling or cryptographic integrity protection of
filesystem metadata.

Source code for the userspace trust orchestration system and
pre-compiled binariesare available at the following location:

ftp://ftp.enjellic.com/pub/Quixote

The Quixote/TSEM TMA currently implements a very simple deterministic
security model.  The architecture is designed to provide a flexible
framework to support the potential implementation of more advanced
models that use stochastics, inference or other machine learning
methodologies.

Dr. Greg (14):
  Update MAINTAINERS file.
  Add TSEM specific documentation.
  Add magic number for tsemfs.
  Implement CAP_TRUST capability.
  Add TSEM master header file.
  Add primary TSEM implementation file.
  Add root domain trust implementation.
  Implement TSEM control plane.
  Add namespace implementation.
  Add security event description export facility.
  Add event description implementation.
  Implement security event mapping.
  Implement an internal Trusted Modeling Agent.
  Activate the configuration and build of the TSEM LSM.

 Documentation/ABI/testing/tsemfs              |  576 ++++++
 Documentation/admin-guide/LSM/index.rst       |    1 +
 Documentation/admin-guide/LSM/tsem.rst        | 1240 ++++++++++++
 .../admin-guide/kernel-parameters.txt         |    5 +
 MAINTAINERS                                   |    8 +
 include/uapi/linux/capability.h               |    6 +-
 include/uapi/linux/magic.h                    |    1 +
 security/Kconfig                              |   11 +-
 security/Makefile                             |    1 +
 security/selinux/include/classmap.h           |    2 +-
 security/tsem/Kconfig                         |   22 +
 security/tsem/Makefile                        |    2 +
 security/tsem/event.c                         |  474 +++++
 security/tsem/export.c                        |  388 ++++
 security/tsem/fs.c                            |  894 ++++++++
 security/tsem/map.c                           |  497 +++++
 security/tsem/model.c                         |  598 ++++++
 security/tsem/namespace.c                     |  226 +++
 security/tsem/trust.c                         |  134 ++
 security/tsem/tsem.c                          | 1801 +++++++++++++++++
 security/tsem/tsem.h                          |  388 ++++
 21 files changed, 7268 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/tsemfs
 create mode 100644 Documentation/admin-guide/LSM/tsem.rst
 create mode 100644 security/tsem/Kconfig
 create mode 100644 security/tsem/Makefile
 create mode 100644 security/tsem/event.c
 create mode 100644 security/tsem/export.c
 create mode 100644 security/tsem/fs.c
 create mode 100644 security/tsem/map.c
 create mode 100644 security/tsem/model.c
 create mode 100644 security/tsem/namespace.c
 create mode 100644 security/tsem/trust.c
 create mode 100644 security/tsem/tsem.c
 create mode 100644 security/tsem/tsem.h

-- 
2.39.1
