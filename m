Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7D12AAE1
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120849; cv=none; b=u0TOJqWzp11m3U5PEaRHvh3rXZSRUR1+7zN9OeP7g4xdxqtlaYlvzx8bZdodCFS4zrR0ITcSIDxRSZBS+rOfZV6I/rbYz2Z67a1W09OsO/eIgCezE4sDY4aPoSgYMEHsVbRkIGGez1r8/8dyFMPbRSX4KSfUE3O1fx66bD2lrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120849; c=relaxed/simple;
	bh=MICtpGs6zSqhUr2E+Ne1WpJTzfLWSkf6rVRDqQtRI34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACJqmnShN/GJBObuqZgewIV06lLD3HVvNIdV8R1aohaf18Xi0WpEl1xiNhrZXvSvvBveTtpvj3sF+yXOSi+QIWYetMVQm7z4qmOXFI7/qnTQlCpM/6C4RgTItTzOV9tu8VFqLLWyZsWJqZCE+ED1pu1ZCmn1GOzthV7lTDSVSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OmsHSG9D; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OmsHSG9D"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5100c4aa08cso2125729e87.2
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 10:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706120844; x=1706725644; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3wp26pORWumECbzJWinoQTFNJx6FsiqC4jXvkpoexag=;
        b=OmsHSG9Dlr3Zn0s3eX17TV/pWozia3QRa3epOdgmuOaIOugwkbwekMNWRmsHWp1Lct
         cI4PV9Mz/WsGGh1sl5Hrzb2x6aw1UGzwSPp6NxK1lVtkmFtElObj/qnLodgCFdjRxDAp
         ckQnbbvGggOmktd1SWsYxWa5XcEcHum6Fsppc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120844; x=1706725644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3wp26pORWumECbzJWinoQTFNJx6FsiqC4jXvkpoexag=;
        b=n53gpY0NQ+oQpC3iijUKgKmZBR0ck+T6/fMrezoYE48hAun1fy6+Tw2AyGYjwN0eO8
         Ry188yrJoU7wmrAovI/tuQm0hz+wPjbBZAObJgbXV90IToMWZCKr0qfIIHE3+aJjTAeM
         UvF/K0oPqDHPqD0p6DcAIE9BXo/t9Xn8huFKD8BgoynVHopwyWBTG38FFqgw7CR2p8rU
         Si6tRG+BUl7+O51RyHW3Q+pmI/lbkEFNOw0AvvrzwYgcnjwQ6cj8OURGJi5ZlBS5Glae
         DXLk1j6TkfrFoWGSg6pr5Cd2vJUDW77wLDhmy3Hfc6T09eh64QlLqZDkyGdsdnOzl9FH
         23qg==
X-Gm-Message-State: AOJu0Yx1YN7M067i5p63if4V6lxhV+9qlty8lCRGYopuSNbKZLkQB6Yw
	MpfmxqEwOoWRBrQTiHfg6L9XIAEOuH7Wn+MtdxuOhCw0vZbvHIhPXP+xsQDdJf1tRDsJUq95+Qp
	HZ2LVWQ==
X-Google-Smtp-Source: AGHT+IEZCS+Pdv1fiG3e7YhE2cyoRukBANw33BslIvWvjtFjHQcZ0uO20fwNyCmRi6obJ7R/phXaZA==
X-Received: by 2002:a05:6512:e88:b0:50f:ff88:18cf with SMTP id bi8-20020a0565120e8800b0050fff8818cfmr2693006lfb.5.1706120843920;
        Wed, 24 Jan 2024 10:27:23 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v19-20020ac25933000000b0050e9a8057f6sm215838lfi.259.2024.01.24.10.27.21
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 10:27:23 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf1b770833so18623691fa.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 10:27:21 -0800 (PST)
X-Received: by 2002:a2e:8ed3:0:b0:2cf:2a3e:d1a4 with SMTP id
 e19-20020a2e8ed3000000b002cf2a3ed1a4mr557545ljl.3.1706120841173; Wed, 24 Jan
 2024 10:27:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook> <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
In-Reply-To: <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 10:27:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
Message-ID: <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>
Cc: Kevin Locke <kevin@kevinlocke.name>, Josh Triplett <josh@joshtriplett.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000af6da8060fb53687"

--000000000000af6da8060fb53687
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 09:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, I think the goal here should be "minimal fix" followed by "remove
> that horrendous thing".

Ugh. The tomoyo use is even *more* disgusting, in how it uses it for
"tomoyo_domain()" entirely independently of even the ->file_open()
callback.

So for tomoyo, it's not about the file open, it's about
tomoyo_cred_prepare() and friends.

So the patch I posted probably fixes apparmor, but only breaks tomoyo
instead, because tomoyo really does seem to use it around the whole
security_bprm_creds_for_exec() thing.

Now, tomoyo *also* uses it for the file_open() callback, just to confuse things.

IOW, I think the right thing to do is to split this in two:

 - leave the existing ->in_execve for the bprm_creds dance in
boprm_execve(). Horrendous and disgusing.

 - the ->file_open() thing is changed to check file->f_flags

(with a comment about how FMODE_EXEC is in f_flags, not f_mode like it
should be).

IOW, I think the patch I posted earlier - and Kees' version of the
same thing - is just broken. This attached patch might work.

And as noted, since it checks __FMODE_EXEC, it now allows the uselib()
case too. I think that's ok.

UNTESTED. But I think this is at least a movement in the right
direction. The whole cred use of current->in_execve in tomoyo should
*also* be fixed, but I didn't even try to follow what it actually
wanted.

           Linus

--000000000000af6da8060fb53687
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_lrs46mby0>
X-Attachment-Id: f_lrs46mby0

IHNlY3VyaXR5L2FwcGFybW9yL2xzbS5jICB8IDQgKysrLQogc2VjdXJpdHkvdG9tb3lvL3RvbW95
by5jIHwgNSArKystLQogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvYXBwYXJtb3IvbHNtLmMgYi9zZWN1cml0eS9h
cHBhcm1vci9sc20uYwppbmRleCA3NzE3MzU0Y2UwOTUuLjk4ZTExNTBiZWU5ZCAxMDA2NDQKLS0t
IGEvc2VjdXJpdHkvYXBwYXJtb3IvbHNtLmMKKysrIGIvc2VjdXJpdHkvYXBwYXJtb3IvbHNtLmMK
QEAgLTQ2OSw4ICs0NjksMTAgQEAgc3RhdGljIGludCBhcHBhcm1vcl9maWxlX29wZW4oc3RydWN0
IGZpbGUgKmZpbGUpCiAJICogQ2FjaGUgcGVybWlzc2lvbnMgZ3JhbnRlZCBieSB0aGUgcHJldmlv
dXMgZXhlYyBjaGVjaywgd2l0aAogCSAqIGltcGxpY2l0IHJlYWQgYW5kIGV4ZWN1dGFibGUgbW1h
cCB3aGljaCBhcmUgcmVxdWlyZWQgdG8KIAkgKiBhY3R1YWxseSBleGVjdXRlIHRoZSBpbWFnZS4K
KwkgKgorCSAqIElsbG9naWNhbGx5LCBGTU9ERV9FWEVDIGlzIGluIGZfZmxhZ3MsIG5vdCBmX21v
ZGUuCiAJICovCi0JaWYgKGN1cnJlbnQtPmluX2V4ZWN2ZSkgeworCWlmIChmaWxlLT5mX2ZsYWdz
ICYgX19GTU9ERV9FWEVDKSB7CiAJCWZjdHgtPmFsbG93ID0gTUFZX0VYRUMgfCBNQVlfUkVBRCB8
IEFBX0VYRUNfTU1BUDsKIAkJcmV0dXJuIDA7CiAJfQpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvdG9t
b3lvL3RvbW95by5jIGIvc2VjdXJpdHkvdG9tb3lvL3RvbW95by5jCmluZGV4IDNjM2FmMTQ5YmYx
Yy4uZThmYjAyYjcxNmFhIDEwMDY0NAotLS0gYS9zZWN1cml0eS90b21veW8vdG9tb3lvLmMKKysr
IGIvc2VjdXJpdHkvdG9tb3lvL3RvbW95by5jCkBAIC0zMjcsOCArMzI3LDkgQEAgc3RhdGljIGlu
dCB0b21veW9fZmlsZV9mY250bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwK
ICAqLwogc3RhdGljIGludCB0b21veW9fZmlsZV9vcGVuKHN0cnVjdCBmaWxlICpmKQogewotCS8q
IERvbid0IGNoZWNrIHJlYWQgcGVybWlzc2lvbiBoZXJlIGlmIGNhbGxlZCBmcm9tIGV4ZWN2ZSgp
LiAqLwotCWlmIChjdXJyZW50LT5pbl9leGVjdmUpCisJLyogRG9uJ3QgY2hlY2sgcmVhZCBwZXJt
aXNzaW9uIGhlcmUgaWYgZXhlY3ZlKCkuICovCisJLyogSWxsb2dpY2FsbHksIEZNT0RFX0VYRUMg
aXMgaW4gZl9mbGFncywgbm90IGZfbW9kZS4gKi8KKwlpZiAoZmlsZS0+Zl9mbGFncyAmIF9fRk1P
REVfRVhFQykKIAkJcmV0dXJuIDA7CiAJcmV0dXJuIHRvbW95b19jaGVja19vcGVuX3Blcm1pc3Np
b24odG9tb3lvX2RvbWFpbigpLCAmZi0+Zl9wYXRoLAogCQkJCQkgICAgZi0+Zl9mbGFncyk7Cg==
--000000000000af6da8060fb53687--
