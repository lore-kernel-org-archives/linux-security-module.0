From: luto@amacapital.net (Andy Lutomirski)
Date: Mon, 2 Apr 2018 18:47:05 -0700
Subject: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <CAGXu5j+UWQWDacMvvRCke3xUOb7uTkxn=WaHzG4kJTKWh-6tAA@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk>
	<alpine.LRH.2.21.1803311145180.7769@namei.org>
	<186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
	<CAGXu5j+UWQWDacMvvRCke3xUOb7uTkxn=WaHzG4kJTKWh-6tAA@mail.gmail.com>
Message-ID: <70C7A8C3-3DCC-4448-9FBD-534ADDE2D6E6@amacapital.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> On Apr 2, 2018, at 5:59 PM, Kees Cook <keescook@chromium.org> wrote:
> 
>> On Mon, Apr 2, 2018 at 5:37 PM, Andy Lutomirski <luto@kernel.org> wrote:
>>> On 03/30/2018 05:46 PM, James Morris wrote:
>>> 
>>>> On Sat, 31 Mar 2018, David Howells wrote:
>>>> 
>>>> Date: Thu, 26 Oct 2017 17:37:38 +0100
>>>> 
>>>> Hi James,
>>>> 
>>>> Can you pull this patchset into security/next please?  It has been in
>>>> linux-next since the beginning of March.
>>>> 
>>>> It adds kernel lockdown support for EFI secure boot.
>>> 
>>> 
>>> Applied to
>>> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
>>> next-lockdown and next-testing
>>> 
>>> Are there any known coverage gaps now?
>>> 
>>> 
>>> 
>> 
>> This is an attempt at a review.  I'm replying here because I can't find the
>> actual relevant patch emails.
>> 
>> Cover letter:
>> 
>>> Here's a set of patches to institute a "locked-down mode" in the
>>> kernel and to trigger that mode if the kernel is booted in secure-boot >
>>> mode or through the command line.
>> 
>> I think this is seriously problematic in that it's not well defined.  It
>> sounds like "locked-down mode" means "make me feel good about something".
> 
> Naming of this feature has been multi-year bikeshedding, so if we
> could just leave the name, that'd be nice.

Fair enough. How about enum kernel_lockdown_level with three modes?

> 
> 

>> "Restrict /dev/{mem,kmem,port} when the kernel is locked down": this should
>> probably split into one restriction for read and one for write.
> 
> I think splitting read and write is only useful if there is a use-case
> for only blocking one of them. I struggle to imagine allowing write
> and blocking read, so really it's the case of wanting to allow read
> and disallow write. Is there actually a use-case for this? In all the
> "locked down" cases I've seen, both are desired.
> 

Let?s suppose for the sake of argument that UEFI really has a good reason to block writes. Blocking reads (kprobes, perf, etc) sounds extremely annoying, especially if running a stock distro, and I?d much rather not do it unless there?s a specific use case that needs it. --
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
