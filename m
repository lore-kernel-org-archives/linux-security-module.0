From: keescook@chromium.org (Kees Cook)
Date: Fri, 21 Jul 2017 10:37:24 -0700
Subject: [PATCH v3 04/15] selinux: Refactor to remove bprm_secureexec hook
In-Reply-To: <CAHC9VhTeU3cH3E+SgW+F4sYm6zxdEip0LYR_Ht0O9TDFQrzGMw@mail.gmail.com>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-5-git-send-email-keescook@chromium.org>
	<CAHC9VhTLP7kpJW65y_csgnc9hvp8ouB36U2WPyHGYgGtq8M4hg@mail.gmail.com>
	<CAHC9VhQJxyRF4f1vX6+00uVHbn8DJDBRLPyRFhU4SBQKGcgQMw@mail.gmail.com>
	<CAGXu5j+ayWRKxn5EneOAJO-XXTo2qsxo-nwKLtjoM60_H6PFOA@mail.gmail.com>
	<CAHC9VhQRhQAbH4c5ZjdEJy-fcMz=oUrd5F4Q755AHVFZVmFR+w@mail.gmail.com>
	<CAGXu5j+mFMRKhjSwkzYZ1qMDCoD44g42wYpLBPm3m2Zjq5BwNA@mail.gmail.com>
	<CAHC9VhQoLxRFFuVSoDPqCS3Gy5fHx5uXxFTcEGCi9d=UWmZkEg@mail.gmail.com>
	<CAHC9VhTeU3cH3E+SgW+F4sYm6zxdEip0LYR_Ht0O9TDFQrzGMw@mail.gmail.com>
Message-ID: <CAGXu5jLT1V_=9Hh-DDJJqvf9Z7ZeaCpLbXnLLZ-e+JTQb2u99w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 21, 2017 at 8:40 AM, Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jul 20, 2017 at 4:42 PM, Paul Moore <paul@paul-moore.com> wrote:
>> On Thu, Jul 20, 2017 at 1:06 PM, Kees Cook <keescook@chromium.org> wrote:
>>> On Thu, Jul 20, 2017 at 6:42 AM, Paul Moore <paul@paul-moore.com> wrote:
>>>> Alternatively, if you've got a fairly recent git repo with all the
>>>> patches merged I can build a test kernel and give it a shot for you,
>>>> although fair warning it may take a day or two for me to get to it.
>>>
>>> Hurm, I think this will take quite a bit of time for me to set up. :P
>>> If you have a chance, I'd appreciate it if you could test the series.
>>> It's currently based on v4.12:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/setuid-rlimits/secureexec-no-hook
>>>
>>> If it doesn't work out or takes too much time I can work on setting up
>>> the test environment next week (travelling at the moment).
>>
>> Building a kernel now, in case anyone on Fedora wants to play with it,
>> you can find it here (when it finishes):
>>
>> * https://copr.fedorainfracloud.org/coprs/pcmoore/kernel-testing/build/581947
>
> Quick follow up, the kernel above passes the selinux-testsuite atsecure test.

Awesome, thanks for taking the time to test it. :) Can I add your Tested-by?

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
