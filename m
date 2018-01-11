From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Thu, 11 Jan 2018 21:17:45 +0200
Subject: [RESEND PATCH v2 0/2] mm: genalloc - track beginning of allocations
Message-ID: <20180111191747.2350-1-igor.stoppa@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This is a partial resend:
- the primary functionality (PATCH 1/2) is unmodified
- while waiting for review, I added selftest capability for genalloc (2/2)


During the effort of introducing in the kernel an allocator for
protectable memory (pmalloc), it was noticed that genalloc can be
improved, to know how to separate the memory use by adjacent allocations

However, it seems that the functionality could have a value of its own.

It can:
- verify that the freeing of memory is consistent with previous allocations
- relieve the user of the API from tracking the size of each allocation
- enable use cases where generic code can free memory allocations received
  through a pointer (provided that the reference pool is known)

Details about the implementation are provided in the comment for the patch.

I mentioned this idea few months ago, as part of the pmalloc discussion,
but then I did not have time to follow-up immediately, as I had hoped.

This is an implementation of what I had in mind.
It seems to withstand several test cases i put together, in the form of
self-test, but it definitely would need thorough review.


I hope I have added as reviewer all the relevant people.
If I missed someone, please include them to the recipients.



Igor Stoppa (2):
  genalloc: track beginning of allocations
  genalloc: selftest

 include/linux/genalloc-selftest.h |  30 +++
 include/linux/genalloc.h          |   3 +-
 init/main.c                       |   2 +
 lib/Kconfig                       |  14 ++
 lib/Makefile                      |   1 +
 lib/genalloc-selftest.c           | 402 ++++++++++++++++++++++++++++++++++++
 lib/genalloc.c                    | 417 ++++++++++++++++++++++++++------------
 7 files changed, 738 insertions(+), 131 deletions(-)
 create mode 100644 include/linux/genalloc-selftest.h
 create mode 100644 lib/genalloc-selftest.c

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
