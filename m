From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 18:59:48 -0400
Subject: [PATCH] selinux: Remove unnecessary check of array base in
	selinux_set_mapping()
In-Reply-To: <CANEJEGu5L61TgJ0RUhG+DvLExj7X1FsfKbGOXWCMRRWykkLm2A@mail.gmail.com>
References: <20170316222652.125702-1-mka@chromium.org>
	<CANEJEGtObzAs4ZT70A_y_bLNujaNLxzOSPjrWRoY3wAR9211jw@mail.gmail.com>
	<CAHC9VhSVqYuuBvyjWmAqgfn9WvFW=VokcLLqsvmKedee3Gjgfw@mail.gmail.com>
	<CANEJEGu5L61TgJ0RUhG+DvLExj7X1FsfKbGOXWCMRRWykkLm2A@mail.gmail.com>
Message-ID: <CAHC9VhTWA=OVDFymUAhvpoEYHgfsxSKKSm316Q0Ox4-9t23NOQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Mar 23, 2017 at 1:34 PM, Grant Grundler <grundler@chromium.org> wrote:
> On Thu, Mar 23, 2017 at 5:08 AM, Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Mar 22, 2017 at 8:28 PM, Grant Grundler <grundler@chromium.org> wrote:
>>> Ping? Any feedback on this patch?
>>
>> It's on my list of patches to review, patience please.
>
> No problem! Thank you!
>
> just wanted confirmation it wasn't overlooked.

Merged, thanks for your patience.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
