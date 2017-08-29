From: mjg59@google.com (Matthew Garrett)
Date: Tue, 29 Aug 2017 12:50:35 -0700
Subject: [apparmor] [PATCH] RFC: Add Apparmor policy matching to IMA
In-Reply-To: <9780464d-80c8-e397-d97b-26451eb502d1@canonical.com>
References: <20170829190401.18056-1-mjg59@google.com>
	<9780464d-80c8-e397-d97b-26451eb502d1@canonical.com>
Message-ID: <CACdnJusB8iN=Otjsfk41Su5nvOh3w2a8VevCjjJXUkEYmEDJGQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Aug 29, 2017 at 12:47 PM, John Johansen
<john.johansen@canonical.com> wrote:
> On 08/29/2017 12:04 PM, Matthew Garrett wrote:
>> IMA has support for matching based on security context, but this is
>> currently limited to modules that implement the audit_rule_match hook.
>> The infrastructure around this seems to depend on having 32 bit security
>> IDs to reference the policy associated with tasks or files, which
>> doesn't seem to be a concept that Apparmor really has. So, this
>> implementation ignores the abstraction and calls through to Apparmor
>> directly.
>>
>> This seems ugly, so is there a better way to achieve this?
>
> probably via secids :/
>
> secid support in apparmor is a wip, and we are hoping to land full support
> in 4.15
>
> I'll see if I can't get a dev branch with them up for you this week.

Oh, that'd be great, thank you!

> that said if you wanted to land this sooner I am not opposed to this
> going in with a minor change (see below) on the apparmor end

4.15 would be fine, I can use this implementation for internal testing.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
