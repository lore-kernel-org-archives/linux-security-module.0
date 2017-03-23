From: grundler@chromium.org (Grant Grundler)
Date: Thu, 23 Mar 2017 10:34:30 -0700
Subject: [PATCH] selinux: Remove unnecessary check of array base in
	selinux_set_mapping()
In-Reply-To: <CAHC9VhSVqYuuBvyjWmAqgfn9WvFW=VokcLLqsvmKedee3Gjgfw@mail.gmail.com>
References: <20170316222652.125702-1-mka@chromium.org>
	<CANEJEGtObzAs4ZT70A_y_bLNujaNLxzOSPjrWRoY3wAR9211jw@mail.gmail.com>
	<CAHC9VhSVqYuuBvyjWmAqgfn9WvFW=VokcLLqsvmKedee3Gjgfw@mail.gmail.com>
Message-ID: <CANEJEGu5L61TgJ0RUhG+DvLExj7X1FsfKbGOXWCMRRWykkLm2A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Mar 23, 2017 at 5:08 AM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Mar 22, 2017 at 8:28 PM, Grant Grundler <grundler@chromium.org> wrote:
>> Ping? Any feedback on this patch?
>
> It's on my list of patches to review, patience please.

No problem! Thank you!

just wanted confirmation it wasn't overlooked.

cheers,
grant

>
>> On Thu, Mar 16, 2017 at 3:26 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>>>
>>> 'perms' will never be NULL since it isn't a plain pointer but an array
>>> of u32 values.
>>>
>>> This fixes the following warning when building with clang:
>>>
>>> security/selinux/ss/services.c:158:16: error: address of array
>>> 'p_in->perms' will always evaluate to 'true'
>>> [-Werror,-Wpointer-bool-conversion]
>>>                 while (p_in->perms && p_in->perms[k]) {
>>>
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>  security/selinux/ss/services.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/security/selinux/ss/services.c
>>> b/security/selinux/ss/services.c
>>> index 082b20c78363..2f20b5f974f4 100644
>>> --- a/security/selinux/ss/services.c
>>> +++ b/security/selinux/ss/services.c
>>> @@ -155,7 +155,7 @@ static int selinux_set_mapping(struct policydb *pol,
>>>                 }
>>>
>>>                 k = 0;
>>> -               while (p_in->perms && p_in->perms[k]) {
>>> +               while (p_in->perms[k]) {
>>>                         /* An empty permission string skips ahead */
>>>                         if (!*p_in->perms[k]) {
>>>                                 k++;
>>> --
>>> 2.12.0.367.g23dc2f6d3c-goog
>>>
>>
>
>
>
> --
> paul moore
> www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
