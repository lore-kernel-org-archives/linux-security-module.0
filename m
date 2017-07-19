From: keescook@chromium.org (Kees Cook)
Date: Tue, 18 Jul 2017 21:40:03 -0700
Subject: [PATCH v3 02/15] exec: Rename bprm->cred_prepared to
	called_set_creds
In-Reply-To: <CALCETrVNWFpS7VKAK02Om6U3u3g5h0R4nBDJ02cbHmLKd7NKQw@mail.gmail.com>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-3-git-send-email-keescook@chromium.org>
	<CALCETrVNWFpS7VKAK02Om6U3u3g5h0R4nBDJ02cbHmLKd7NKQw@mail.gmail.com>
Message-ID: <CAGXu5jK9Gio6kYmmSsUA2uJ4qhqFRVqsed+CibtqnZd2ETGGaQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 18, 2017 at 6:06 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Tue, Jul 18, 2017 at 3:25 PM, Kees Cook <keescook@chromium.org> wrote:
>> The cred_prepared bprm flag has a misleading name. It has nothing to do
>> with the bprm_prepare_cred hook, and actually tracks if bprm_set_creds has
>> been called. Rename this flag and improve its comment.
>>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: John Johansen <john.johansen@canonical.com>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Cc: Stephen Smalley <sds@tycho.nsa.gov>
>> Cc: Casey Schaufler <casey@schaufler-ca.com>
>> Cc: James Morris <james.l.morris@oracle.com>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  fs/binfmt_flat.c           | 2 +-
>>  fs/exec.c                  | 2 +-
>>  include/linux/binfmts.h    | 8 ++++++--
>>  security/apparmor/domain.c | 2 +-
>>  security/selinux/hooks.c   | 2 +-
>>  security/smack/smack_lsm.c | 2 +-
>>  security/tomoyo/tomoyo.c   | 2 +-
>>  7 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
>> index 2edcefc0a294..a722530cc468 100644
>> --- a/fs/binfmt_flat.c
>> +++ b/fs/binfmt_flat.c
>> @@ -885,7 +885,7 @@ static int load_flat_shared_library(int id, struct lib_info *libs)
>>          * as we're past the point of no return and are dealing with shared
>>          * libraries.
>>          */
>> -       bprm.cred_prepared = 1;
>> +       bprm.called_set_creds = 1;
>
> WTF is this?  It's not, strictly speaking, a bug in this patch, but
> it's nonsensical.  Is it fixed (presuably deleted) later?

binfmt_flat looks crazy, but I haven't seen any distros that enable it.

> Otherwise looks good.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
