From: dhowells@redhat.com (David Howells)
Date: Mon, 24 Sep 2018 13:18:26 +0100
Subject: [PATCH 0/2] KEYS: Revert and replace incorrect UAPI fix
Message-ID: <153779150602.28003.4692837431529288988.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


Hi James,

Here's a pair of fixes that need to go upstream asap, please:

 (1) Revert an incorrect fix to the keyrings UAPI for a C++ reserved word
     used as a struct member name.  This change being reverted breaks
     existing userspace code and is thus incorrect.

     Further, *neither* name is consistent with the one in the keyutils
     package public header.

 (2) Fix the problem by using a union to make the name from keyutils
     available in parallel and make the 'private' name unavailable in C++
     with cpp-conditionals.

David
---
David Howells (1):
      keys: Fix the use of the C++ keyword "private" in uapi/linux/keyctl.h

Lubomir Rintel (1):
      Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name"


 include/uapi/linux/keyctl.h |    7 ++++++-
 security/keys/dh.c          |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)
