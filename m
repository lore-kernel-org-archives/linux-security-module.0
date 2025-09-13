Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179F1E3DF2
	for <linux-security-module@vger.kernel.org>; Sat, 13 Sep 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757782874; cv=none; b=bzzJ3gTGor+BW59qR7PSO+NLPP0zweDBA5Nje1VqVYjneCqH1CN3bYCOA706nRBMySRX7CfoOMleD3tj7ihVysYMDlkFnC8v5ickOcGud+pMu8Um9bvaRhEVOvInR8OpFd6Zsn0UTRBwv1GS1YjFamIrgKmsmedRtg7f8SZ11U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757782874; c=relaxed/simple;
	bh=fAl811+LJx+57xhD3ZDBRMsx59Zi632qqhWlpTaXmmQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=bUFJRMZ2DA0x3MLYO4C5/z1M5zlrIr1vnMs7l/2Uwz37DxGdQlt2tJypu3zUxIEkiGjmlI0yPL6A0SgdtB+I0V9qKkZk4yUAsjjFERO+/3aMiCw4r6m5HKosCgjw0bT5zUOrhlG4AHhS2Trn8uS/eb2KcS10wQas8y3HgYZ3qls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dvjll8GJ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dvjll8GJ"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so1626098f8f.2
        for <linux-security-module@vger.kernel.org>; Sat, 13 Sep 2025 10:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757782871; x=1758387671; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8jVrbxVggAGGjVPECN0iWVqlzdgucYLKcpcWurPyD3c=;
        b=Dvjll8GJ0wnD0ppxn4LNP6U8prNscBJo1opMdLj3djyH6IZZ9qgnwIhswWC6Ij937R
         N7HU3rDW05qtyUGzK2CUDClWIUiTUrmSQJQ64I03lv8uPdUs0iTf906qEYpLQP90er7h
         QF0VoK2n1mvjPCmj7wx0J8xwenYCXEvkGAxKgsHXWAgVG2TNN4kXRcvyt2PdAeruftEe
         yqrqi/SGPGgoyRj27+nRrwCDK53ZcfQ/n7lmq2uSTho6XJx/GbmRrjvgAN9EBT5pwFoI
         FxGiHXQIxR1y9BJ2AK4nnfsh3tU/vTjg6+HEnyt6CBOQrscbTuYzZ4KZwTBK+R87IYSN
         QkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757782871; x=1758387671;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jVrbxVggAGGjVPECN0iWVqlzdgucYLKcpcWurPyD3c=;
        b=QD5mFds6+rq9yxi7gzqwn3wpHmlXbNy8zMUemDErQFViCv/jZMDuQRC4H1uyw7lo4v
         6jOkbQoLeauiPQ1GCQsMMF8ac835zMU45tB3/2CzaxjY35gKtaWMmUpMU7Bf3b2wIy5S
         l4ofCTAygq8kEj5QCK+OqbuPI67PimlmABp5tMm63ixcF7avaTwgWcpxLTp7J7fF8PMw
         6wXju0GCJD1TW+LA6u4HjzB6IQThHTEaCagP2WlKfCkstqVMyv+J4vhy1MHRsjrlVT0F
         Wv4bsAj4Ap2avkSDyeAMEAYo/dwGdUM63K+CG4Vx893J3p8r1K+jKi/0HI3yxVtcEJjc
         r1BA==
X-Gm-Message-State: AOJu0YzvHZEaFwwOjKpXfmakz/BKKfzHFhQ/8tNRlCONmXpBFKAFHjWO
	l2xA4ZxWdBO/uygA4jAIrhFooEYYm5kLFS00qxnwnbNKFTXsefL0euWrwqlAJa2Qy50=
X-Gm-Gg: ASbGnctBfWG0Bbt2EdHugj0rWpe3uJdaCATR2tewlU4mlEQefSSJchJ8ZUNddNO4yIP
	6Zhfg+Lm/nzF0GLlWj5wRU7OfL2R5Fit1+4pYVJrZBEfH+5XYnrmUEW8gzNi99hAfIY5mhqTl4u
	Jzqw+PCra9C46rUIQZta621HetA5GKphCASKbb4Xvy5u1WunOLlIhLz7N7Jqg3lgK9HVDBXrfxW
	zhqC26WuVSdMtKOoJfrMd4ceC7udh/4r6zxQRdU9cCJwkU/kf7bHTcQ0bGkMV4P4F4KmgYS6S2q
	QQOTzBJZAAXzItngPLEPKAHBbZzM5Y4Ymb1HUgNbPhgwxSWQDKucFeLiMGvx69gVkDVk/Fics4v
	x8vOmlnMqPngfPB490I/lmuhOlWcs1Vr6JVwlyfCjGDvTvVhY6RIFF09rSyMKhzAWZPP6ZmC2s7
	dQGuc=
X-Google-Smtp-Source: AGHT+IHxuiEOQg1v7lYGNdadask14TKYGQh97aQt2avC5UpjAiAMPfP2BgCYtn/tTDqWMXPMlc9qqA==
X-Received: by 2002:a05:6000:2510:b0:3e4:ea11:f7df with SMTP id ffacd0b85a97d-3e7659db441mr6402177f8f.40.1757782870686;
        Sat, 13 Sep 2025 10:01:10 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e80da7f335sm4379634f8f.8.2025.09.13.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 10:01:09 -0700 (PDT)
Message-ID: <e5d594d0aee93da67a22a42d0e2b4e6e463ab894.camel@gmail.com>
Subject: [bug report] [regression?] bpf lsm breaks /proc/*/attr/current with
 security= on commandline
From: Filip Hejsek <filip.hejsek@gmail.com>
To: linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
  James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Date: Sat, 13 Sep 2025 19:01:08 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello,

TLDR: because of bpf lsm, putting security=3Dselinux on commandline
      results in /proc/*/attr/current returning errors.

When the legacy security=3D commandline option is used, the specified lsm
is added to the end of the lsm list. For example, security=3Dapparmor
results in the following order of security modules:

   capability,landlock,lockdown,yama,bpf,apparmor

In particular, the bpf lsm will be ordered before the chosen major lsm.

This causes reads and writes of /proc/*/attr/current to fail, because
the bpf hook overrides the apparmor/selinux hook.

As you can see in the code below, only the first registered hook is
called (when reading attr/current, lsmid is 0):

int security_getprocattr(struct task_struct *p, int lsmid, const char *name=
,
			 char **value)
{
	struct lsm_static_call *scall;

	lsm_for_each_hook(scall, getprocattr) {
		if (lsmid !=3D 0 && lsmid !=3D scall->hl->lsmid->id)
			continue;
		return scall->hl->hook.getprocattr(p, name, value);
	}
	return LSM_RET_DEFAULT(getprocattr);
}

Even though the bpf lsm doesn't allow attaching bpf programs to this
hook, it still prevents the other hooks from being called.

This is maybe a regression, because with the same commandline, reading
from /proc/*/attr/current probably worked before the introduction of
bpf lsm.

Regards,
Filip Hejsek
