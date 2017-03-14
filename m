From: ldv@altlinux.org (Dmitry V. Levin)
Date: Tue, 14 Mar 2017 05:57:35 +0300
Subject: Compat 32-bit syscall entry from 64-bit task!?
In-Reply-To: <CAObL_7GM0n80N7J_DFw_eQyfLyzq+sf4y2AvsCCV88Tb3AwEHA@mail.gmail.com>
References: <CAObL_7EA-Z8yBbr1+-VW0v8k1okdcMfjRe5LgWo8YL5uvOkXbQ@mail.gmail.com>
	<201201260032.57937.vda.linux@googlemail.com>
	<ca17a86f7c88f8884e4ffc9bafbf2dff.squirrel@webmail.greenhost.nl>
	<201201260209.54513.vda.linux@googlemail.com>
	<CA+55aFzDZhGoa1TH=RAtjK3Ti3=NPAYvreSxiTxTu3wnu8Z61g@mail.gmail.com>
	<CAK1hOcNFmG+3NTfQ559T-LkbcmcVfk9eF=JesdOqqj97tJncaw@mail.gmail.com>
	<20170308234154.GA2352@altlinux.org>
	<CAObL_7GM0n80N7J_DFw_eQyfLyzq+sf4y2AvsCCV88Tb3AwEHA@mail.gmail.com>
Message-ID: <20170314025735.GA18046@altlinux.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Mar 08, 2017 at 08:39:55PM -0800, Andrew Lutomirski wrote:
> On Wed, Mar 8, 2017 at 3:41 PM, Dmitry V. Levin wrote:
[...]
> > Is there any progress with this (or any alternative) solution?
> >
> > I see the kernel side has changed a bit, and the strace part
> > is in a better shape than 5 years ago (although I'm biased of course),
> > but I don't see any kernel interface that would allow strace to reliably
> > recognize this 0x80 case.
> 
> I am strongly opposed to fudging registers to half-arsedly slightly
> improve the epicly crappy ptrace(2) interface for syscalls.
> 
> To fix this right, please just add PTRACE_GET_SYSCALL_INFO or similar
> to, in one shot, read out all the syscall details.  This means: arch,
> no, arg0..arg5, and *whether it's entry or exit*.  I propose returning
> this structure:
> 
> struct ptrace_syscall_info {
>   u8 op;  /* 0 for entry, 1 for exit */
>   u8 pad0;
>   u16 pad1;
>   u32 pad2;
>   union {
>     struct seccomp_data syscall_entry;
>     s64 syscall_exit_retval;
>   };
> };
> 
> because struct seccomp_data already gets this right.  There's plenty
> of opportunity to fine-tune this.  Now it works on all architectures.

Unfortunately, the API is missing.

Unlike syscall_get_nr(), syscall_get_arch() works with the current task
only so there is no API to get the arch identifier for the given task
that would work on all architectures.


-- 
ldv
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170314/b41c126c/attachment.sig>
