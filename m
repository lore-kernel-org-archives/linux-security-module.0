From: keescook@chromium.org (Kees Cook)
Date: Sat, 15 Sep 2018 18:49:07 -0700
Subject: [PATCH 07/18] LSM: Add minor LSM initialization loop
In-Reply-To: <CAG48ez3aU5XtQxUzWE3N3f4JyCz0jFchC=CAnHTZkGZaryWFxQ@mail.gmail.com>
References: <20180916003059.1046-1-keescook@chromium.org>
	<20180916003059.1046-8-keescook@chromium.org>
	<CAG48ez3aU5XtQxUzWE3N3f4JyCz0jFchC=CAnHTZkGZaryWFxQ@mail.gmail.com>
Message-ID: <CAGXu5jK6wPLQRte4S3cnSgDZ7LoVugtTytK5iW5c_XYRq7HA5w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Sep 15, 2018 at 6:27 PM, Jann Horn <jannh@google.com> wrote:
> On Sun, Sep 16, 2018 at 3:11 AM Kees Cook <keescook@chromium.org> wrote:
>> Split initialization loop into two phases: "exclusive" LSMs and "minor"
>> LSMs.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  include/linux/lsm_hooks.h | 6 ++++++
>>  security/security.c       | 8 +++++---
>>  2 files changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index f8e618e2bdd2..ec3419b9b16f 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -2039,7 +2039,13 @@ extern char *lsm_names;
>>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
>>                                 char *lsm);
>>
>> +enum lsm_type {
>> +       LSM_TYPE_EXCLUSIVE = 0,
>> +       LSM_TYPE_MINOR,
>> +};
>
> Is the intent of this explicit zero assignment that LSM_TYPE_EXCLUSIVE
> should be the default? If so, perhaps a comment "/* default */", or
> something like that, might be helpful.

You cut the patch quote off where I do exactly that:

>> +       enum lsm_type type;     /* Optional: default is LSM_TYPE_EXCLUSIVE */

:)

-Kees

-- 
Kees Cook
Pixel Security
