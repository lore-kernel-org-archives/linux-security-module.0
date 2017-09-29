From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 28 Sep 2017 17:33:34 -0700
Subject: [RFC PATCH 3/3] fs: detect that the i_rwsem has already been
	taken exclusively
In-Reply-To: <1506643967.5691.46.camel@linux.vnet.ibm.com>
References: <1506602373-4799-1-git-send-email-zohar@linux.vnet.ibm.com>
	<1506602373-4799-4-git-send-email-zohar@linux.vnet.ibm.com>
	<20170928220215.GC15067@dastard>
	<CA+55aFy-kDL5jQb0q2gHkcmhAwMatEf8YPx8Gh=yGp_VMoVxQA@mail.gmail.com>
	<1506643967.5691.46.camel@linux.vnet.ibm.com>
Message-ID: <CA+55aFxqpTbC=sZXrbJ0x1OD-UA1NkejuR_s5LCazp+7yzvi3Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Sep 28, 2017 at 5:12 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
>
> Originally IMA did define it's own lock, prior to IMA-appraisal.  IMA-
> appraisal introduced writing the file hash as an xattr, which required
> taking the i_mutex.  process_measurement() and ima_file_free() took
> the iint->mutex first and then the i_mutex, while setxattr, chmod and
> chown took the locks in reverse order.  To resolve the potential
> deadlock, the iint->mutex was eliminated.

Umm. You already have an explicit invalidation model, where you
invalidate after a write has occurred.

But the locking of the generation count (or "invalidation status" or
whatever) can - and should be - entirely independent of the locking of
the actual appraisal.

So make the appraisal itself use a semaphore ("only one appraisal at a time").

But use a separate lock for the generation count.
So then appraisal is:

 - get appraisal semaphore
      - get generation count lock
            read generation count
      - drop generation count lock
      - do the actual appraisal
 - drop appraisal semaphore

Note that you now have a tuple of "generation count, appraisal" that
you have *not* saved off yet, but it's your stable thing.

Now you can write the xattr:

  - get exclusive inode lock (for xattr)
      - get generation count lock
          - if the appraisal generation does not match, do NOT write
the appraisal you just calculated, since it's pointless: it's already
stale.
          - otherwise write the appraisal and generation count to the xattr
      - drop generation count lock
  - release exclusive inode lock

and then for anything that does setxattr or chmod or whatever, just
use that generation count lock to invalidate the appraisal. You don't
need to actual appraisal lock for that.

So now the appraisal lock is always the outermost one, and the
generation count lock is always the innermost.

Anyway, I haven't looked at the details of what IMA does, but
something like the above really sounds like it should work and seems
pretty straightforward.

No?

               Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
