Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86A30D3F6
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jun 2026 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780611799; cv=pass; b=Y3yPBs1vlom0vo3snuQWVjmEsltjrBpR6LJn/NChp58+GIEY3G0f6zPbrgn5K5TQRAryiTxSFh5cBBiydjIriGHiapHy1lmad8Bjmaph15cb/gKX9qMtU0ASqV37bXlRLz6sDsoBPsfJRdbTVfJ9xR6L07Q8QfS5qYsuKEpiq7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780611799; c=relaxed/simple;
	bh=sv7u946dDPt6bQWxS+BMmnxYNE48PGMJ11+6cCv1z7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aBbUQtyndd+/HZRCgAlR2HCAnBJm4yO5O4+ZvJw6ySHC8Vbn2Ssnlb49XXTf9tXkI0H0+Ql+c4Zf/koUB899RDmbLzf7G6VfU6VuVQVHXEgg2iAKE6vI/6sUtXeuXD5d1dSbKfpiX7nPIDyouWoBlUmw3iVd9RGsiYQ4sOdv9Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MHJzxE0+; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MHJzxE0+"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-841882f8f4bso552633b3a.0
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jun 2026 15:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780611797; cv=none;
        d=google.com; s=arc-20240605;
        b=NW7UgSrJ0okYTsWkwZeL0feXOKJxh4PERvgfrIhKfcO1tvEZnAEN2PmcbrK/UFcR1s
         0fhyqYSJATNLbDhnet12yIV9G/Z0G7X8krnMSXxvaeT/kZu2DHnGzFl90xLG9ZevnBeY
         mOHa/gWknwhW8G6qCvH2zn7E9BqElOH5WwNsmIL5lxA/sQmRB5xk26DOeuH6J7DcmsOY
         5XybSt1aJysW9twJTttWGW9ui9ZZNF+qI37OniLNSfTKp/laYFctsRps3jF87NdV5jjo
         +HHQDOJkC3icPszhz1DKuwhcbiqN+DndG5MNN4d3YIUKq1PVOA1UNgnDlAIYAs/LG4Yq
         K+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pihXm2znUTB2Pr0aH9CbpJxNZjUXIGY7ehFMK0p5h+I=;
        fh=/xaH0XAXfxmZ3p4tN06SRmUz9b0W7YCNeLuwhGO5uVM=;
        b=SpC30qQzSXRy1uYIHYTPOCqqvx1/RYo0mP7o82AnIf2VZGUYSotwQ1K/W643vqFiIV
         B9G/FmyornTNZW006DXdkVagz2nB7MalaXxAcyUS3tMXuaZbOeWHd6VX6/Qmb7qi00Hs
         B34DvjutrII7nDDqrCGhjiowmWya19WAhLsAVs+LWrF+O6Wv+zUtH8z6X5mjTZbfyiyL
         3VJPJBm8Kdx4qMIAdLCVf7LCkED4BU2sajyICYRlvfjpsp7tHzup0CvMBuFqgwqAIUKi
         9dWBaKJw3S7QvJpDLZ2oVbe8qvq7IABUhVhNjGIudo//Zb2tBhSMhHLngrt1gTkNWaoQ
         yp2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780611797; x=1781216597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pihXm2znUTB2Pr0aH9CbpJxNZjUXIGY7ehFMK0p5h+I=;
        b=MHJzxE0+OskseWSqPOkWLUBwXAQQ4gpWuCxTsWv4CUA7QwW2RSIX+8Pl0vN0D/ImFL
         6IvWjFlQsqfs9F4Emas2/LrjHlWdepmvTMXS5FbUPzUhhfDOlZ6c6Qt6uv4cGIWpoXy/
         U8hRFioZDLAcMrX9AwG5Cj895YVI4LuS6kAyb+ubli+BiJ5dKcwZgHGlIDcH0FaMBTU4
         fMQq1IV7y7X6yDKnwwbWgr3txDOmy0HVM0PPIX6O2s4pLKeoDofNYSDdVfxS5ouSJbhm
         W5H8npJ2oVN8s/QShpYNhydCNzmDu0EZ0OsXAo8MiixUBv1cLBOegzXQb5qpe/+LEztx
         n3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780611797; x=1781216597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pihXm2znUTB2Pr0aH9CbpJxNZjUXIGY7ehFMK0p5h+I=;
        b=Z4sVeQMDqdWcpNzCEeUTWEBAPb5xFU2COBEfOVA4K5NmR5klaUBBKSpUxzdwixWCeY
         YPdfoSwzjSTIRBGscwLPrda29GKEPcV7SBk8iorrIacxCETMBcZcZZtgmQEGlEdlOUVj
         lFDrvnXV8UkjuiZLj8KjtP3coVq11rFWeGH6MXecZUndy/WccBeBoC7nob/bTpYK9r/a
         NPaeXtLAGC/mxXOtzTyDolgY09eRbQsyfHjD0Hl3Q+4pXwDYMcLwCPenCVsAi3JkCJ0I
         fvPJkgroc4EspA221Q6YogTr9FlL1O0xdTVQBXFRQv7tUfziP31tkB1xZqS9PMZdNsHA
         MF4g==
X-Gm-Message-State: AOJu0YyAsUaNVSRHnJKiN7hCLZroAoWwA9ZLHXEyQ+dggXWl0W5Gynrl
	V29wAuJ14+HbqGkWwTqb7dL7mDenoCgYKORhUTcrX2bzQ22Po4qxrhSX4mgIp6ZVHUH/oKqtUeu
	OpUJ/2gLmg8LSTPUV7OYhJDr4T88Y2K+EzMDhWZ8c
X-Gm-Gg: Acq92OEhIcjhoMHDvrwb4Sq+x+uBO3o66qtNNZQskI/H9T0Upi+XR4Sb6leHh5gOzHS
	53Ph8n3DTRZzgghWoIhim8jrmjmYp9LzPlgWyR0ryX7aWJFpV02RVbXAlG1ecnEKWm5+hJG66Kt
	z8YdJkkPjuQ1yDnYcMKiBuqUk06NJdkFyOz7/F3QbgZ4ifUqq60hqIU0l+zYAsdgwMbFpKh6heh
	kIKfpxX1jb8GJ6zKVKvxrEbTRn6lUaMtrMs0y+MXnvEgNhaI54ay0NZjHPXeD4b2NMx5bCiw+Qa
	GQyVpAtAZxeVz0NL5w==
X-Received: by 2002:a05:6a00:9a6:b0:842:3aee:12c0 with SMTP id
 d2e1a72fcca58-842b0f4d125mr572659b3a.23.1780611797364; Thu, 04 Jun 2026
 15:23:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83f77b2b-8c00-424d-b6f9-b044e7ea1ee7@sirena.org.uk>
 <CAHk-=wj6CtZS9hbwFjQcoNkPwQLoyKmk8czaBF6=bBOCYuXEUQ@mail.gmail.com>
 <CAHC9VhRX1=tx4+arzuH76kirYFFJozexa5L=41Bb2QbgWZXOkQ@mail.gmail.com> <CAHk-=wj_rtiufEEVudMCSbh86HYrnmEa9NhYfKeWHs1SOzJVnA@mail.gmail.com>
In-Reply-To: <CAHk-=wj_rtiufEEVudMCSbh86HYrnmEa9NhYfKeWHs1SOzJVnA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Jun 2026 18:23:04 -0400
X-Gm-Features: AVHnY4IWCLJ4YD6K4pLZd33BtQj_cRah5eC6RDvamIb2F_A5rRJQWkfp4uHn4XY
Message-ID: <CAHC9VhRXW_kyWXgYBqW3K-jSr5yN9wp1EPos1c=BFmiebxLiUQ@mail.gmail.com>
Subject: Re: -next status as at v7.1-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, linux-next@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 8:32=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 3 Jun 2026 at 17:04, Paul Moore <paul@paul-moore.com> wrote:
> >
> > It's worth mentioning that resolving the merge issue was relatively
> > straightforward and we had a tested patch ready in a few hours
>
> This is not the reason I'm not going to pull it ...

I didn't assume the merge issue was the reason, but you felt it was
worth mentioning so I figured it deserved a response.

> ...  the merge issue was
> just the reminder I got about an earlier email that I had dropped on
> the floor.
>
> No, the reason I won't pull it is that the main developer I pull bpf
> code NAK'ed it.

I would like to clarify some things, not necessarily for Hornet's
sake, but because they have implications moving forward.  As much as I
*love* our little chats, I think we both would prefer not to repeat
this discussion in the future.

While you didn't reply to any of my comments explaining how Hornet
works, specifically how it ties into the kernel, I'm assuming you've
read the overview.  Can you help those of us in the LSM space
understand why a BPF dev's NACK on code that lives strictly under
security/ is sufficient grounds to reject an LSM patch?

Disagreement about what access controls an LSM is allowed to enforce?

Disagreement about using LSMs for additional signature verification,
despite compatibility (although one could argue we already do this
with IMA)?

Use of the bpf_map_ops::map_get_hash() method?

Other things ... ?  I'm genuinely not trying to be antagonistic; I'm
trying to understand your thinking in rejecting Hornet and take some
lessons away from it.  I'm currently stuck with (pardon the
paraphrase) "because Alexei said-so", and while I'm certain Alexei
would be happy to have that codified, I'd like to believe there is
more to your rejection than that.

> My tree is *not* some kind of "we are bypassing developers by sending
> a pull request directly to Linus" tree.

I've been sending you pull requests for a while now, and as you know
I'm always very upfront in the email if any of the commits contain a
NACK or even the absence of a cross-subsystem ACK.  My intention is
never to deceive anyone, my goal is always to make you aware of the
situation so that you can decide what to merge into your tree.

That was why I decided to merge Hornet into the LSM dev/next branch in
preparation for the upcoming merge window.  You had been CC'd on
several threads regarding the BPF signature verification work and
hadn't provided guidance on the cross-subsystem issues.  Even an
off-list email I sent you received what could best be described as a
shrug.  My plan was to present Hornet to you with an explanation,
likely similar to my last reply in this thread, detailing that we had
worked with the BPF devs for over a year and their solution actively
ignored our requirements (despite their claims otherwise).  Hornet,
while NACK'd by Alexei, did not touch any code under kernel/bpf/, was
compatible with the existing BPF verification code, and solved real
user problems.

While I was not looking forward to the discussion, I felt responsible
for trying one last time to bring this to your attention and make a
case for the signature verification requirements the BPF community has
chosen to reject.  It appears a private, off-list email from the BPF
devs preempted this, which is unfortunate regarding both visibility
and timing, but at least we are still having a discussion of sorts.

> And honestly, I also have two+ decades of history of "LSM people
> cannot agree on a single thing".

You've repeated this enough that I worry your opinion has ossified,
but I can promise you the reality is that the LSM maintainer community
is a reasonably tight knit group and has been for quite some time.
I'm laughing a bit as I write this (I know ...), but I would encourage
you to drop by the Linux Security Summit in Prague this fall; I
believe you'll already be in town for the Maintainer Summit and it
might be an opportunity to see some of us and realize we agree far
more than you envision.  You might particularly enjoy our "working
with Linus" support group that meets in the evening at a local bar ;)

--=20
paul-moore.com
