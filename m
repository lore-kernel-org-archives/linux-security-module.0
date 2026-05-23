Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ABD2DC32E
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546870; cv=pass; b=li76azuKzU/1XJgrmFTabqKn7ESgYXhvn5UsZGjDU9r6vDAPCdzsMcIedKziGO/e6A3gBGTxs1E/fVwaOjNVGzROdZ/4MBbRyhLdVg+iyiwL76/JTPHMAis8TFJAIwKcapBnklBMTcpQe/n5Spti92tL3HNcBc49eIEevaMAGIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546870; c=relaxed/simple;
	bh=noHj4o6L6mRCDVYatvCJMFZCUqtzX7swxU7UIuIdMYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5mEkS4D3GNzVgCQU4n9VfAELuNIUaWD/AewMLsu6cTz/RaDVX2KjRMS2vppe7xVv5LHSuvs9/zM8e561Gdvps5fwyB9RRygGrb7TefnHk87UEkIfwcrofyL8WQavFbCUWGYgsihfxqZrBOjp3mOMkjiTXKl98aiFRFiZlXCzpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYX8bT8E; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYX8bT8E"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48fde648a71so55550655e9.0
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 07:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779546867; cv=none;
        d=google.com; s=arc-20240605;
        b=iPpHdaRDqH33iWUE126NrMbnj2yLb0vuFG/5Xzy5CYl/ww5VJKksokC+sCXibcAVaC
         ryNUwAEBvfK3frIsaexVSAbu3xMMB4RNoTYV43M5XzwxS6A5tJy8wMu99CYzSPJfBY5g
         4JF3zAxMYCOWkxtTS+Hl7Y9mZpEdlZKrd3oQBpYhdnKrh8dQqwWoMND3hrGWDsQYYn/V
         CtEHrnqyjtlUEnMvb9RDdGkQXWGq7D4WnYJsVCAERithFSSkIW88J/PLSc/gfJQqNwq3
         ZsLq/VwDxtJfXWTD9DnhbUFQlP9ckvZowQUQX0GK0Q6RJl9K4XDLbnKUULLUrCDN1rJQ
         pOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=noHj4o6L6mRCDVYatvCJMFZCUqtzX7swxU7UIuIdMYA=;
        fh=GF9wPT2bR3mwmstmSZPwlNcrmAr8sHy5WlpXWWmgQgU=;
        b=bsvO2QODMPnZun35h30khPlH2vIbeNv9IDfypuNurxTdVKtD02j40N2TRI8cwc4dp8
         hXuIilsRhhDIDEJxClcguvSSXXcyLQiW8Y8RvYwuFkTTr+cWzRIoGIzwnIq3mZizBSAY
         901ZMZ+XVueOmEougcyzSaL4Cq6fK4oI2ZymkeFzVeMPmtALy+9UAk5w6fqW2OAjBQPd
         OpabsCBFSxZyq9tqP64wPMMXTrIKvx+OaEOGm8g/reMUsjsJF5dhD+jHtWzRm3MHTT43
         /OcUyHxqstA3t9XRsQS2gYI3piv7EXmWyoLf0OhXtbJv4XWBzSPfDRVeWcOnOYrE3TGA
         IMRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779546867; x=1780151667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noHj4o6L6mRCDVYatvCJMFZCUqtzX7swxU7UIuIdMYA=;
        b=kYX8bT8EH3Vnb539+DiExAqq0nzoZUViOafrv062kmy1OxnHRDzdyC/k5AvFANTYj2
         XzkQnJ1hVFv26mH7HaseZzrDhLPr9z56fH+HVWiuaO/6oqHkRjiCyihVB78CgPZZLfa6
         0lCiiBMLyQKEg8F5i3hOOIzFyFGZjSgBq5OM1ihcc/QK6N8EjI1AEtmSUoI2MMOn7TzT
         jiiyAoJFbalmlwdOqm6ZaRIJd7ndsu6vybe1ExcjbGqgluoINsmB04c+R0PtIUrFRZ1j
         1KKxYYl7JGcV4NYNY1MkyyihXaCsk1KHaqwDAgeGcpDlexRiasmchdzW1oj6TnssJrva
         PcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779546867; x=1780151667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=noHj4o6L6mRCDVYatvCJMFZCUqtzX7swxU7UIuIdMYA=;
        b=spOyNCnhxJeQwddLseWcHr8+C44uBY4dQ62tAu8sMDVgyDafKgLC2kcTCJjXWNwTUK
         6WTpLAiSHxlbDi92yvMgU0SryteoxUx3gRmb27ULfO1BI5K8T+/1/Uz+egd3xFp6BUKq
         O6gnJa9T8xg4AdeqnUjGCs5uhUQNK8KtXtK3uhGQjV5xdsc2+DxF5iua+dm46MPB1YgY
         iy8lDevMuqPE/1UdM5KHXNgXuddxdfO94Fpm+wu+Xa8K0VyzHt7raeB5XibAnhBh6n1S
         Qbeu8GvE6tHWe9FMMDAB/RGiWkTq++cdyV40yGpMfl9bOZVcQHLA2OoVFi7siSSZlWiz
         fp/w==
X-Forwarded-Encrypted: i=1; AFNElJ9ZK4f3zzZN54tBko8pHz9LzUa/dHjr2XxNhJwV/vCol2AR+LsOujBdC7mftffiPf7DWRL6vMzbNNnGcK8H8W7b6N6VjmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb6B9o0ISo8eWm3GcjBfGcK7+bZeDvsi71s25snuDC8ZhFF12t
	oKOHJdF5Rg8Rm0WazqDwDyK1BHWrpvRBhAHoeresmQyu4ne1uxK5xsH9NF+K29s5c3GssZ028i4
	rh4cEPi9XNrPVOzJFw96WYtaHIRCVF9aGbVG8
X-Gm-Gg: Acq92OHy0ZKJlaLFRfYgylhowsA8M2u+StcVlS/Qh9TsqQwd/y9osFAmBi2MXoelMZ7
	wdEAwbbR7Q+IooxRSRbxsAMWRsOpZHyvuijSnEd32+LCz2pvsICuRx75J6oqeY1Mt8Qu+UHHUnx
	/ial3f1cBlXPZ8tAF2cS/S+n6QLzMUhcmm/SOrl1lxEP3E15i8TZ28Y1b7bzhiZuY+ZlZx/JUR8
	dfVzYkDsEP9/aQF2Gd8r95T2s3FtJ8leNjTNWZ12k63LUgUiXj2Msa1MQrBNoRvznDmz0l4khpQ
	qfySHBbd9bWmEgYaCNHggQutWeXXyGGNwO6gLqDj/E16r5Zjr/P5fMd3AgTJ3jL5gLdbZsC4eHk
	L7ao=
X-Received: by 2002:a05:600d:6443:20b0:490:548f:6ca0 with SMTP id
 5b1f17b1804b1-490548f6dc2mr14333455e9.8.1779546866581; Sat, 23 May 2026
 07:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <CAHC9VhTk3qovnQQjK0C_FWU605j6Yi+-poMVVMS8WycRFg9xhQ@mail.gmail.com>
 <CAADnVQLbCz8nCLS2W=Hpk3hVSBqHGuGyVjeKYPnNDhhu_1UiPQ@mail.gmail.com> <19e54da1d28.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <19e54da1d28.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 16:34:15 +0200
X-Gm-Features: AVHnY4IC-tTMKFx_0wpiYAXbGHoriQblp2jY3sf1fSSlKaxC5pprAVRKEGtp9pU
Message-ID: <CAADnVQ+Kx1YikuzMDt8Zv+tGXYUvgDuah9P-f5a=VBpnYb1K5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] Signed BPF + IPE Policies
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 2:40=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 23, 2026 3:40:46 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Fri, May 22, 2026 at 8:56=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >> Blaise has recorded Alexei's NACK on the Hornet patchset and addressed
> >> the TOCTOU that Alexei identified.
> >
> > It wasn't addressed. You simply ignored my feedback.
>
> Blaise most certainly did update his patches based on your feedback.
> Perhaps there were multiple issues that weren't communicated well?
>
> > sashiko spotted it too.
> > All other sashiko bugs were ignored as well.
>
> Link? I didn't see any feedback from sashiko feedback on list and to the
> best of my knowledge it hasn't been enabled for LSM patches.

Check your emails. sashiko replied multiple times to all
of Blaise's versions and found lots of issues.
