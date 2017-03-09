From: luto@mit.edu (Andrew Lutomirski)
Date: Wed, 8 Mar 2017 20:39:55 -0800
Subject: Compat 32-bit syscall entry from 64-bit task!?
In-Reply-To: <20170308234154.GA2352@altlinux.org>
References: <CAObL_7EA-Z8yBbr1+-VW0v8k1okdcMfjRe5LgWo8YL5uvOkXbQ@mail.gmail.com>
	<201201260032.57937.vda.linux@googlemail.com>
	<ca17a86f7c88f8884e4ffc9bafbf2dff.squirrel@webmail.greenhost.nl>
	<201201260209.54513.vda.linux@googlemail.com>
	<CA+55aFzDZhGoa1TH=RAtjK3Ti3=NPAYvreSxiTxTu3wnu8Z61g@mail.gmail.com>
	<CAK1hOcNFmG+3NTfQ559T-LkbcmcVfk9eF=JesdOqqj97tJncaw@mail.gmail.com>
	<20170308234154.GA2352@altlinux.org>
Message-ID: <CAObL_7GM0n80N7J_DFw_eQyfLyzq+sf4y2AvsCCV88Tb3AwEHA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Mar 8, 2017 at 3:41 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> Hi,
>
> On Thu, Jan 26, 2012 at 07:03:43PM +0100, Denys Vlasenko wrote:
>> Hi Linus,
>>
>> On Thu, Jan 26, 2012 at 4:47 AM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> >> Please look at strace source, get_scno() function, where
>> >> it reads syscall no and parameters. Let's see....
>> >> - POWERPC: has 32-bit and 64-bit mode
>> >> - X86_64: has 32-bit and 64-bit mode
>> >> - IA64: has i386-compat mode
>> >> - ARM: has more than one ABI
>> >> - SPARC: has 32-bit and 64-bit mode
>> >>
>> >> Do you want to re-invent a different arch-specific way to report
>> >> syscall type for each of these arches?
>> >
>> > I think an arch-specific one is better than trying to make some
>> > generic one that is messy.
>> >
>> > As you say, many architectures have multiple system call ABIs.
>> >
>> > But they tend to be very *different* issues. They can be about
>> > multiple ABI's, as you mention, and even when they *look* similar
>> > (32-bit vs 64-bit ABI's) they are actually totally different issues.
>> > [skip]
>>
>> I don't have a particular attachment to my solution,
>> and I think we already talk about this problem for
>> far too long.
>>
>> Looks like nobody is _strongly_ opposed to your patch
>> which uses a few bits in eflags to report bitness
>> of the x86 syscall.
>>
>> Lets just do that already. If you commit it to kernel git,
>> I will immediately change strace accordingly.
>
> Is there any progress with this (or any alternative) solution?
>
> I see the kernel side has changed a bit, and the strace part
> is in a better shape than 5 years ago (although I'm biased of course),
> but I don't see any kernel interface that would allow strace to reliably
> recognize this 0x80 case.

I am strongly opposed to fudging registers to half-arsedly slightly
improve the epicly crappy ptrace(2) interface for syscalls.

To fix this right, please just add PTRACE_GET_SYSCALL_INFO or similar
to, in one shot, read out all the syscall details.  This means: arch,
no, arg0..arg5, and *whether it's entry or exit*.  I propose returning
this structure:

struct ptrace_syscall_info {
  u8 op;  /* 0 for entry, 1 for exit */
  u8 pad0;
  u16 pad1;
  u32 pad2;
  union {
    struct seccomp_data syscall_entry;
    s64 syscall_exit_retval;
  };
};

because struct seccomp_data already gets this right.  There's plenty
of opportunity to fine-tune this.  Now it works on all architectures.

Since struct seccomp_data may be extended in the future, the operation
should be:

ptrace(PTRACE_GET_SYSCALL_INFO, pid, (void *)sizeof(struct
ptrace_syscall_info), &info);

returns 0 on success and some error code if, for example, the current
ptrace stop isn't a syscall entry or exit.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
