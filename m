Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F62155CAF;
	Mon, 26 Aug 2024 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669418; cv=none; b=F44pdDR6M8UeEudDaPL/F/Jo4RfCnZpHrJiv+cqKrBdqimQDNsvukeC0f/d28cq3qkAbU5LrvaC1P+fsnRu2U+gCrVaN7iHQmKRE9ERDim4/D6VrDYQ3vBbGGpdhHEkg36m6JEtPOrZPJVkvMYyZg7ezJ9HTIegfHP2rSgDwvgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669418; c=relaxed/simple;
	bh=UUFJrei0OumLms1I0qyRHxSyE6cxS1dp/bmeovEUbn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MuXX50tIE9w889bs/bv5bN/rMt/OYloWgS+c0JDYc2bHk/pauHSRc1iybwUkOHS6gw379TlIS1m4ZfHvBcG2witp5kiJnnOiTZwWu68xppBJyd3vacPI5AhQtx15SEc/VquJ9HFfLeKYZXB/LUHNNdzKFsGontKTYAFtC3XQatU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 47QAbUEL003401;
	Mon, 26 Aug 2024 05:37:30 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 47QAbS0S003400;
	Mon, 26 Aug 2024 05:37:28 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v4 00/14] Implement Trusted Security Event Modeling.
Date: Mon, 26 Aug 2024 05:37:14 -0500
Message-Id: <20240826103728.3378-1-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Good morning, I hope this note finds the week starting well for
everyone.

This is the fourth release of Trusted Security Event Modeling (TSEM)
as a new Linux Security Module (LSM) architecture.

TSEM provides kernel infrastructure that allows the implementation of
arbitrary model based mandatory access controls.  TSEM is model
agnostic and provides infrastructure for implementing deterministic,
quasi-deterministic, probabilistic or machine learning (AI) based
security models.

TSEM also provides a framework for generic security monitoring that
can be used to implement Endpoint Detection and Response (EDR) systems
without the need to write kernel code, implement kernel modules or
attach BPF programs.

The only privileges needed for an EDR system based on TSEM is the
ability to open the pseudo-file that exports security event
descriptions for a security modeling namespace.  This provides a
framework for Linux to avoid the possibility of experiencing a
'CrowdStrike Calamity'.

TSEM operates under the premise, that operating system security, like
all other physical phenomena in science and engineering, can be
mathematically modeled.  TSEM notionally treats the LSM security event
handlers as a basis set of parameters that can be used to generate a
functional value for the security state of a system or a confined
workload.

TSEM uses generative functions, rather than static labels, to create
the positive accession elements of a multi-dimensional access vector
matrix.  In doing so, it provides for the highly precise attestation
of the trust status of a platform or workload.  In the case of a
security violation, it also provides very precise forensic
characterizations of the security event.

TSEM's task identity model enables very precise detection and
characterization of adversarial strategies such as Living Off The Land
(LOTL).

TSEM is designed to support the concept of a Trust Orchestration
System (TOS).  Trust orchestration involves the process of modeling
the security behavior of a workload, or a platform at large, and
defining whether or not a process is to be trusted, based on whether
or not the security events produced by it are consistent with a
security behavior that the workload or platform has been unit tested
to.

TSEM, in and of itself, does not implement a security policy or model.
That capability is invested in an entity known as a Trusted Modeling
Agent (TMA).  A TMA can be implemented in the kernel itself or the
security event descriptions can be exported to userspace for
processing in a non-kernel based TMA.

To support this architecture, TSEM implements entirely within the
context of the LSM architecture, the concept of security modeling
namespaces that are similar in concept to other resource namespaces.
A security modeling namespace is paired with a TMA that implements the
root of trust for a namespace.

A TMA implementation uses the characteristics of the calling process
and the descriptive parameters of a security event to drive generative
functions that compute security state coefficients for each security
event.  The sum of these coefficients, represents the security 'state'
of a model.

TSEM supports any number of security modeling namespaces that act
independently of one another and of the root security modeling
namespace.  Each namespace can be configured with its own unique
security model definition that can be modeled internally or
externally.  Alternately, the security modeling namespace can
asynchronously export all of the security events for external review
and analysis.

Security models to be enforced by a trust orchestrator in a security
modeling namespace are developed by unit testing of a workload.  This
approach increases model precision and thus decreases the risk of the
mandatory controls breaking applications or expected system behavior.

TSEM thus represents a security architecture that is designed to be
paired with modern software development strategies that embrace
resource containerization and Continuous Integration and Continuous
Delivery principles.  The objective of TSEM, along with the Quixote
TOS implementation, is to bring to Linux security architectures what
Docker brought to Linux resource namespaces.

TSEM implements support for modifying the processing of security
events through the use of loadable modules on systems that have
loadable module support enabled.  Each security modeling namespace can
select either the default event processing model or any of the event
models that have been loaded at the time of namespace creation.

The userspace utilities include an example of a small loadable module
that allows a security modeling namespace to implement functionality
equivalent to the Linux Integrity Measurement Architecture (IMA).

Included with the implementation is an extensive documentation file
that can be found in the following location in the kernel sources
after application of the patch series.

Documentation/admin-guide/LSM/tsem.rst

TSEM formats security event descriptions into JSON encoded messages
that can be consumed and analyzed by any JSON consuming data
visualization, analysis, modeling or ingress system.

The following documentation file documents the control plane interface
for TSEM including the JSON encoding format:

Documentation/ABI/testing/tsem

Reviewers, and others who are interested, are referred to these
documents for a more extensive discussion into the rationale, design
and implementation of the TSEM architecture.

Control of TSEM is surfaced entirely via the securityfs filesystem
through the following directory hierarchy:

/sys/kernel/security/tsem

TSEM is designed to be self-contained and independent of the kernel at
large and with other LSM's with which it stacks.  Since the security
guarantee resides in an externally created security model definition,
it operates without the need for filesystem labeling or cryptographic
integrity protection of filesystem metadata.

The Quixote userspace utilities that are needed to create, manage,
interrogate and model security modeling namespaces are available at
the following project site:

https://github.com/Quixote-Project

Included in the userspace tools are implementations of trust
orchestrator's and TMA's for the following trust roots:

Kernel.

Userspace process.

SGX enclave.

Xen hypervisor stub-domain.

Hardware based security coprocessors.

An export only utility is also available that will read asynchronously
exported security event descriptions.  The export utility includes
support for MQTT based broker connections that allow either on-premise
or cloud based EDR systems to be implemented.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity

V1:
- Initial release.	  

V2:
- V1: https://lore.kernel.org/linux-security-module/20230204050954.11583-1-greg@enjellic.com/T/#t
- Allow compile time configuration of the Platform Configuration
  Register used to extend security coefficients in the root
  security modeling namespace.
- Allow both internal and external modeling of security events
  that are called in atomic context.
- Use JSON to encode security event characteristics.
- Use securityfs for TSEM control plane rooted at
  /sys/kernel/security/tsem.
- Use framework of separate directories for internal TMA's to
  protect ABI compatability.
- Use key=value arguments for control plane commands.
- Allow cryptographic hash function used for coefficient
  generation to be configured on a namespace by namespace basis.
- Allow selection of initial or current user namespace as the
  reference for UID/GID resolution to be configured on a namespace
  by namespace basis.
- Allow the size of modeling and export structures to be configured
  on a namespace by namespace basis.
- Extensively document all globally visible enumerations and structures.
- Use CAP_ML rather than CAP_TRUST for modeling capability bit.
- Implement orchestrator<->process mutual authentication.
- Implement occupancy counts for security state coefficients.
- Move TSEM to the first LSM in the LSM list.

V3:
- V2: https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t
- Require CAP_MAC_ADMIN capability for namespace creation and management.
- Implement full modeling for all TSEM captured LSM events.
- Implement export only namespaces.
- Support export only root security modeling namespaces.
- Support invariant models for namespaces that create files.
- Model all filesystem types.
- Include device types in path descriptions.
- Use bprm_committed_creds for TASK_ID generation.
- Implemented modeling for capget, capset and capable LSM calls.
- Use static keys to optimize control paths.
- Standardize all event handlers to use common format.
- Level tmpfs based filesystems to a common UUID.
- Implement security event timestamps.
- Implement parent event tracking.
- Update TASK_ID generative function to use parent TASK_ID.
- Multiple style and bug fixes.
- Update TSEM documentation including per file functional descriptions.
- Document JSON security event encoding.

V4:
- V3: https://lore.kernel.org/linux-security-module/20240401105015.27614-1-greg@enjellic.com/T/#m1cc4ad76677d07517220f1fadc2303c36a75bab0
- Convert tsem_mode command-line parameter to string arguments.
- Add namespace identity and event sequence numbers to event description.
- Implement selectable event bypass.
- Implement loadable security event processing modules.
- Bug fixes and code corrections and improvements.

Dr. Greg (14):
  Update MAINTAINERS file.
  Add TSEM specific documentation.
  TSEM global declarations.
  Add primary TSEM implementation file.
  Add root domain trust implementation.
  Implement TSEM control plane.
  Add namespace implementation.
  Add security event description export facility.
  Add event processing implementation.
  Implement security event mapping.
  Implement the internal Trusted Modeling Agent.
  Implement configuration and methods for default model.
  Implement infrastructure for loadable security models.
  Activate the configuration and build of the TSEM LSM.

 Documentation/ABI/testing/tsem                | 2420 ++++++++++++++++
 Documentation/admin-guide/LSM/index.rst       |    1 +
 Documentation/admin-guide/LSM/tsem.rst        | 1680 +++++++++++
 .../admin-guide/kernel-parameters.txt         |   29 +
 MAINTAINERS                                   |    8 +
 include/uapi/linux/lsm.h                      |    1 +
 security/Kconfig                              |   11 +-
 security/Makefile                             |    1 +
 security/security.c                           |    3 +-
 security/tsem/Kconfig                         |   36 +
 security/tsem/Makefile                        |    6 +
 security/tsem/event.c                         | 1846 +++++++++++++
 security/tsem/export.c                        |  429 +++
 security/tsem/fs.c                            | 2304 ++++++++++++++++
 security/tsem/map.c                           | 1536 +++++++++++
 security/tsem/model.c                         |  758 +++++
 security/tsem/model0.c                        |   21 +
 security/tsem/namespace.c                     |  530 ++++
 security/tsem/nsmgr.c                         |  255 ++
 security/tsem/nsmgr.h                         |   48 +
 security/tsem/trust.c                         |  261 ++
 security/tsem/tsem.c                          | 2446 +++++++++++++++++
 security/tsem/tsem.h                          | 2336 ++++++++++++++++
 23 files changed, 16960 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/ABI/testing/tsem
 create mode 100644 Documentation/admin-guide/LSM/tsem.rst
 create mode 100644 security/tsem/Kconfig
 create mode 100644 security/tsem/Makefile
 create mode 100644 security/tsem/event.c
 create mode 100644 security/tsem/export.c
 create mode 100644 security/tsem/fs.c
 create mode 100644 security/tsem/map.c
 create mode 100644 security/tsem/model.c
 create mode 100644 security/tsem/model0.c
 create mode 100644 security/tsem/namespace.c
 create mode 100644 security/tsem/nsmgr.c
 create mode 100644 security/tsem/nsmgr.h
 create mode 100644 security/tsem/trust.c
 create mode 100644 security/tsem/tsem.c
 create mode 100644 security/tsem/tsem.h

-- 
2.39.1
