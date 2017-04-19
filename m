From: mic@digikod.net (=?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?=)
Date: Wed, 19 Apr 2017 02:12:16 +0200
Subject: [PATCH net-next v6 00/11] Landlock LSM: Toward unprivileged
	sandboxing
In-Reply-To: <CAGXu5jLpM13xmFf2_bcWH=db7LEavfpZswvPbAM3+66dBPtMTg@mail.gmail.com>
References: <20170328234650.19695-1-mic@digikod.net>
	<CAGXu5jLpM13xmFf2_bcWH=db7LEavfpZswvPbAM3+66dBPtMTg@mail.gmail.com>
Message-ID: <a5597574-6a8c-b2ee-336c-48734071e6ff@digikod.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


On 19/04/2017 01:26, Kees Cook wrote:
> On Tue, Mar 28, 2017 at 4:46 PM, Micka?l Sala?n <mic@digikod.net> wrote:
>> This sixth series add some changes to the previous one [1], including a simpler
>> rule inheritance hierarchy (similar to seccomp-bpf), a ptrace scope protection,
>> some file renaming (better feature identification per file), a future-proof
>> eBPF subtype and miscellaneous cosmetic fixes.
> 
> Sorry for the delay in review! I finally had a chunk of time I could
> devote to this. I really like how it's heading. I still wonder about
> its overlap with seccomp (it's really only using the syscall now...),
> but that's just a detail. Getting the abstraction away from direct LSM
> hooks looks good.
> 
>> There is as yet no way to allow a process to access only a subset of the
>> filesystem where the subset is specified via a path or a file descriptor.  This
>> feature is intentionally left out so as to minimize the amount of code of this
>> patch series but will come in a following series.  However, it is possible to
>> check the file type, as done in the following example.
> 
> I understand why you've taken a progressive approach here, but I think
> there are two fundamental areas where people will use Landlock: path
> evaluation and network address evaluation. I think it's worth
> expanding this series to include those two confinement examples, since
> that can help people understand what the "general" case will look
> like.

I agree that it would be more useful to add a path/FS evaluation,
however we agreed at LPC that it would be another patch series:
https://lkml.kernel.org/r/5828776A.1010104 at digikod.net
It brings more complexity and a new kind of BPF map, which should be
reviewed in a separate series.

> 
> As I mentioned in one of the patch review emails, I think there needs
> to be a clearer explanation of how usage counting works vs the
> "events" (which I think of as "rule tables" not events -- maybe it
> needs a new name?) and "rule" lists. I think I understand it, but I
> spent a lot of time trying to get there. More comments would help.

I though about different names and the previous one was PDP (for Policy
Decision Point) which is used in the literature, but "event" seems
easier to understand and close enough with "hook". Rule tables doesn't
seems to express what is the meaning to register an event/hook.

I'll add more comments to explain how it works.

> 
> Finally, another thing I'm curious about is how to deal with the
> thread-sync issue. Seccomp uses its TSYNC thing, and I'd expect we'd
> want something similar for landlock... but that looks really hairy as
> far as locking goes. Perhaps it's already solved by using the same
> locking seccomp uses, in which case I'm less inclined to kick landlock
> out of seccomp.c. :)

I didn't work on it but it should be really similar to seccomp-bpf.

> 
> Looks like it's coming along nicely! Thanks for continuing to work on this!
> 
> -Kees
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://kernsec.org/pipermail/linux-security-module-archive/attachments/20170419/57ca3a38/attachment.sig>
