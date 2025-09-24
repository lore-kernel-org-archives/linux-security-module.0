Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A9291C13
	for <linux-security-module@vger.kernel.org>; Wed, 24 Sep 2025 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749082; cv=none; b=EHOpJog81cLt51nC399VTJJQY0p5KM8fmBiK+2maUrjbSPygf2lsycru5Kf9YgH/S864nSkeTmm+7B7Bxl1XCwFw+gVMJPq+EvplUmOm6wxQwj2h0VgGx4ro8Bby40rKCDPvBWL4Wj8KYskaw10QZy9DllWizlPPCbAPZGP1acw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749082; c=relaxed/simple;
	bh=yYlJMEiOn4ahL9VGQHqHfLn8g81HGorNFwQNV25DIPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNne0CAkbnUGng92ZgGW3hhVFmuxI+ptHdrAzij2vwd1uDwmNOHwI/YhO/2QTVT6W2lGjmQdDsAsqiL4+Qf3TD5ZDqWyhVg8FDFwBi/aW0IWN6PJ6SP2h0vigH9SGBv/nG79QXvOxPFQzazYSapNv38NWcIPeyibokpubwdDToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FiQOgnCO; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FiQOgnCO"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so375386a91.2
        for <linux-security-module@vger.kernel.org>; Wed, 24 Sep 2025 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758749080; x=1759353880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dhLUMSWCJCb7Nc7Lx/+68xlS8KMxySblqVYlmSCjYI=;
        b=FiQOgnCOJibaeCTr921wkYnyw1rd4ab+Kj4p5eWP8pJXsnyR2P5rAUZ3rVKdL+OZsR
         BS1JsnZ50k55mxRbXrojHcJFe0oDbJP8ZDzfwKO5EaNNEmkHpb6JejFvoxrDlZlEkJgA
         9mnprG/0fVZSAYljqsb3lIURw7zgGJ7Q84gLtTD1EQ2i6pHyJyz8ZSPLtydu1N4TWfnr
         Vi9HYUzcWopX16GuyRPTGynyQd2iEFtBHRj+wHmCaYfmfR0GfqAeGRUbAYQC8rRlN5e2
         flpZ5eJzlrtyf/U9342uZqBmtxzAmVjVGzaW+zBFlwzlgtES4a2K8OCgn9sCKfTHLuJO
         I9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749080; x=1759353880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dhLUMSWCJCb7Nc7Lx/+68xlS8KMxySblqVYlmSCjYI=;
        b=uSsTDhVI4s5xcoXFjOX2J0ifBF7aRypEveeddksnhCvr+k/LbqPU62R4pBDvSPgbhq
         pR2xWcDSfnNESVMqpYQJJFHTOKw/alOrLlktpGVBetRtKb1Zw//LwvqORPO11L2TyPSe
         83ij0EhFiSXViqkL/lM5bwBis3smLofcYv+ejeKqygtjEoZuF1Zxp0hMqk3BE9pWFM6J
         Y/xvmHlHPdZQfBobtK6vtrAbVhvyB+RF9YRvGWsAMufDFMfnmgvYwRVK8yNDradVAYAm
         pKUXXCcdOoBPlNsR0HI8Enii3EUK+7euFOaPD6RoB0Fj5UxmzfJjwCBk1PErgyyesnIf
         ULyg==
X-Gm-Message-State: AOJu0YyOI/Irj/SbOBkcFkKVKFgHmqKpZLmiBFkOQzKHZg2KpbQ+sqOr
	Y48uuR+KrzV7fsdv8/7RJxAP/x7e0bPIiABMmvlbkC/6YuMV4uEgm3MgAFLA90/B5bvp7s7MhmN
	eBhou110jzvW0lkmqwKtc2j8MAiHNeOj4p4mMzQyg
X-Gm-Gg: ASbGncvYUPk+E9anHx0J2LuIAO2mpXRA6q0nrBDw1RJfuwYjX0Tiil7N+vVKZOGDPK1
	PiBXfheCtqyV4+vurihZ95L1ANRnl+qrElnktI8O3j+o4VY+XjnTBXapUZr2eNJqL2aK5qiqeAQ
	qRPsdhTr1V2AkuJqx3qPRYWtnsvskeIw8MKiADXM0Y8RDX39ee7E1H9aRF79OveXmJ0ceAWMUE5
	iN5QIBgf/2Tu7Vx5w==
X-Google-Smtp-Source: AGHT+IHR9pP1MvU0qJbfCGQoZkW8eEMjmqKvK5A67Eqc2Nnt+qxlyEAnQFYtUTxdfOJEIc9WV2+K5Q4lRtal6pKd1BM=
X-Received: by 2002:a17:90b:5343:b0:32d:17ce:49d5 with SMTP id
 98e67ed59e1d1-3342a2b08bcmr1001670a91.23.1758749080200; Wed, 24 Sep 2025
 14:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e5d594d0aee93da67a22a42d0e2b4e6e463ab894.camel@gmail.com>
In-Reply-To: <e5d594d0aee93da67a22a42d0e2b4e6e463ab894.camel@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 Sep 2025 17:24:28 -0400
X-Gm-Features: AS18NWCNQQSQBWtRenUjLlMUKvi01cd9ZXZW5J6vPc0TKqgJOAr2w5N1LESqTqk
Message-ID: <CAHC9VhRu=-J5xdKgYOJ1eqQ6EiMoEJ3M+cjDU8AHrts-=DoTvg@mail.gmail.com>
Subject: Re: [bug report] [regression?] bpf lsm breaks /proc/*/attr/current
 with security= on commandline
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 1:01=E2=80=AFPM Filip Hejsek <filip.hejsek@gmail.co=
m> wrote:
>
> Hello,
>
> TLDR: because of bpf lsm, putting security=3Dselinux on commandline
>       results in /proc/*/attr/current returning errors.
>
> When the legacy security=3D commandline option is used, the specified lsm
> is added to the end of the lsm list. For example, security=3Dapparmor
> results in the following order of security modules:
>
>    capability,landlock,lockdown,yama,bpf,apparmor
>
> In particular, the bpf lsm will be ordered before the chosen major lsm.
>
> This causes reads and writes of /proc/*/attr/current to fail, because
> the bpf hook overrides the apparmor/selinux hook.

What kernel are you using?  Things appear to work correctly on my
kernel that is tracking upstream (Fedora Rawhide + some unrelated
bits):

% uname -a
Linux dev-rawhide-1.lan 6.17.0-0.rc7.250923gd1ab3.57.1.secnext.fc44.x86_64 =
#1 SM
P PREEMPT_DYNAMIC Tue Sep 23 10:07:14 EDT 2025 x86_64 GNU/Linux
% cat /proc/cmdline
BOOT_IMAGE=3D(hd0,gpt4)/boot/vmlinuz-6.17.0-0.rc7.250923gd1ab3.57.1.secnext=
.fc44.x
86_64 root=3DUUID=3D285029fa-4431-45e9-af1b-298ab0caf16a ro console=3DttyS0=
 mitigation
s=3Doff security=3Dselinux
% cat /sys/kernel/security/lsm; echo ""
lockdown,capability,yama,selinux,bpf,landlock,ipe,ima,evm
% id -Z
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
% cat /proc/self/attr/current; echo ""
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023

I even ran it against the LSM initialization rework that has been
proposed, but has not yet been accepted/merged, and that worked the
same as above.

Is this a distro kernel with a lot of "special" patches which aren't
present upstream?

--=20
paul-moore.com
