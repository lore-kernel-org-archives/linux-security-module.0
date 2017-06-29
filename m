From: s.mesoraca16@gmail.com (Salvatore Mesoraca)
Date: Thu, 29 Jun 2017 21:30:58 +0200
Subject: [RFC v2 6/9] Creation of "pagefault_handler_x86" LSM hook
In-Reply-To: <CAGXu5jJ2DykaU6bbFGRcOaZK9nn5dFUYQ6UjXCq9Y97DwYpCyA@mail.gmail.com>
References: <1497544976-7856-1-git-send-email-s.mesoraca16@gmail.com>
	<1497544976-7856-7-git-send-email-s.mesoraca16@gmail.com>
	<CAGXu5jJ2DykaU6bbFGRcOaZK9nn5dFUYQ6UjXCq9Y97DwYpCyA@mail.gmail.com>
Message-ID: <CAJHCu1JxUA0b3mu4Z=NPBdCRv6SfmCKEQ5jGaMsLg2Q_9tm25g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

2017-06-28 1:07 GMT+02:00 Kees Cook <keescook@chromium.org>:
> On Thu, Jun 15, 2017 at 9:42 AM, Salvatore Mesoraca
> <s.mesoraca16@gmail.com> wrote:
>> Creation of a new hook to let LSM modules handle user-space pagefaults on
>> x86.
>> It can be used to avoid segfaulting the originating process.
>> If it's the case it can modify process registers before returning.
>> This is not a security feature by itself, it's a way to soften some
>> unwanted side-effects of restrictive security features.
>> In particular this is used by S.A.R.A. can be used to implement what
>> PaX call "trampoline emulation" that, in practice, allow for some specific
>> code sequences to be executed even if they are in non executable memory.
>> This may look like a bad thing at first, but you have to consider
>> that:
>> - This allows for strict memory restrictions (e.g. W^X) to stay on even
>>   when they should be turned off. And, even if this emulation
>>   makes those features less effective, it's still better than having
>>   them turned off completely.
>> - The only code sequences emulated are trampolines used to make
>>   function calls. In many cases, when you have the chance to
>>   make arbitrary memory writes, you can already manipulate the
>>   control flow of the program by overwriting function pointers or
>>   return values. So, in many cases, the "trampoline emulation"
>>   doesn't introduce new exploit vectors.
>> - It's a feature that can be turned on only if needed, on a per
>>   executable file basis.
>
> Can this be made arch-agnostic? It seems a per-arch register-handling
> routine would be needed, though. :(

S.A.R.A.'s "pagefault_handler_x86" implementation is fully arch specific
so it won't benefit too much from this change.
Anyway having a single hook for all archs is probably a cleaner solution,
I'll change it in the v3.
Would it be OK if I make it arch-agnostic while I actually keep it only
in arch/x86/mm/fault.c?
Thank you for your help.

Salvatore
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
