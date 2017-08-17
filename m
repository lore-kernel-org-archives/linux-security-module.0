From: igor.stoppa@huawei.com (Igor Stoppa)
Date: Thu, 17 Aug 2017 19:26:16 +0300
Subject: [RFC] memory allocations in genalloc
Message-ID: <299c22f9-2e34-36dc-a6da-22eadbc0a59d@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Foreword:
If I should direct this message to someone else, please let me know.
I couldn't get a clear idea, by looking at both MAINTAINERS and git blame.

****

Hi,

I'm currently trying to convert the SE Linux policy db into using a
protectable memory allocator (pmalloc) that I have developed.

Such allocator is based on genalloc: I had come up with an
implementation that was pretty similar to what genalloc already does, so
it was pointed out to me that I could have a look at it.

And, indeed, it seemed a perfect choice.

But ... when freeing memory, genalloc wants that the caller also states
how large each specific memory allocation is.

This, per se, is not an issue, although genalloc doesn't seen to check
if the memory being freed is really matching a previous allocation request.

However, this design doesn't sit well with the use case I have in mind.

In particular, when the SE Linux policy db is populated, the creation of
one or more specific entry of the db might fail.
In this case, the memory previously allocated for said entry, is
released with kfree, which doesn't need to know the size of the chunk
being freed.

I would like to add similar capability to genalloc.

genalloc already uses bitmaps, to track what words are allocated (1) and
which are free (0)

What I would like to do is to add another bitmap, which would track the
beginning of each individual allocation (1 on the first allocation unit
of each allocation, 0 otherwise).

Such enhancement would enable also the detection of calls to free with
incorrect / misaligned addresses - right now it is possible to
successfully free a memory area that overlaps the interface of two
adjacent allocations, without fully covering either of them.

Would this change be acceptable?
Is there any better way to achieve what I want?


---

I have also a question wrt the use of spinlocks in genalloc.
Why a spinlock?

Freeing a chunk of memory previously allocated with vmalloc requires
invoking vfree_atomic, instead of vfree, because the list of chunks is
walked with the spinlock held, and vfree can sleep.

Why not using a mutex?


--
TIA, igor
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
