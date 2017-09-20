From: keescook@chromium.org (Kees Cook)
Date: Wed, 20 Sep 2017 15:25:15 -0700
Subject: [PATCH V4 09/10] capabilities: fix logic for effective root or
	real root
In-Reply-To: <CAHC9VhS4oDiNNjLQD5QwdWaZ2AK3n0v-qP2h9CvF7XLcppSXKA@mail.gmail.com>
References: <cover.1504591358.git.rgb@redhat.com>
	<fcc7f8815666df526110b59d76707d52bd1ca9c9.1504591358.git.rgb@redhat.com>
	<CAHC9VhS4oDiNNjLQD5QwdWaZ2AK3n0v-qP2h9CvF7XLcppSXKA@mail.gmail.com>
Message-ID: <CAGXu5jKoGxi4q+q+1-q3ABxTb5-sVre-OCym8iH6O8zMnDTbrQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 20, 2017 at 3:11 PM, Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Sep 5, 2017 at 2:46 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> Now that the logic is inverted, it is much easier to see that both real
>> root and effective root conditions had to be met to avoid printing the
>> BPRM_FCAPS record with audit syscalls.  This meant that any setuid root
>> applications would print a full BPRM_FCAPS record when it wasn't
>> necessary, cluttering the event output, since the SYSCALL and PATH
>> records indicated the presence of the setuid bit and effective root user
>> id.
>>
>> Require only one of effective root or real root to avoid printing the
>> unnecessary record.
>>
>> Ref: commit 3fc689e96c0c ("Add audit_log_bprm_fcaps/AUDIT_BPRM_FCAPS")
>> See: https://github.com/linux-audit/audit-kernel/issues/16
>>
>> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> Reviewed-by: Serge Hallyn <serge@hallyn.com>
>> Acked-by: James Morris <james.l.morris@oracle.com>
>> ---
>>  security/commoncap.c |    5 ++---
>>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> Trying to sort this out, I've decided that I dislike the capabilities
> code as much as I dislike the audit code.

Read binfmt_elf.c and your journey towards the dark side will be complete!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
