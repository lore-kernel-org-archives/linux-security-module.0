Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDB2232367
	for <linux-security-module@vger.kernel.org>; Tue,  8 Jul 2025 23:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752018905; cv=none; b=cG5xeLc4m9hbudR2jBmIRVOyqimOY/CSuQ1OSUNVzFNsI8X1XQnAFV85XLIP7USvzt9aDx2Q8d617aa0t/gUcCa6sGmZwKWTaAU1gDaiaCuDTjIasTxJH8x8YW9h7ZZ+z6mwUEsw5oPq0L1j3/yg3taUuWGiGuQvWrv2hyKG1sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752018905; c=relaxed/simple;
	bh=wQxWK8jBvglI2zvwv6228wj6glSdtDhMFKEyulOd6Uk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aLqkekEKR8p+jMQ6IE0L7/hsSXNyuw9GvLA8+4QPWa9LgEOWesamKc4RTlW8esepB1ciGDSUxM4Z+qx95flmJpTXZNUmtfwAbyoZFmLKdvkQ6362dFhPkBqqyG9OuftY8JmwcySjhIx04xs+a8UnWSPl3p2XrBThlbUeEf19/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df4d2a8b5eso48989725ab.3
        for <linux-security-module@vger.kernel.org>; Tue, 08 Jul 2025 16:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752018903; x=1752623703;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0dogU16f7slst3dKm7CYnYhI8NIlC8uvBFGVNrpma8=;
        b=GntBdD/uyrP516G0YgPjQdofyTH3l6tzoiHKHk2Py8rumQUciz4f4PTkeh3rCIl68Y
         IFzpPgdW8wDcbrWgPIFmJ/1vEptLFqbglnBF1o4JCXyJhTzlhk006e20FagAQ75Y5AuU
         rfLAhcumOnsZjie+bAElDUvyRpFTz3bb/msrPVcUCqGjV2g2/ukWyew+K9mzVBFpHxxk
         BUSnWD9t4QHSTDHLKYVsonq7PQIRqQNg98+XyGJjKy6UGnr0YRoeuVTjMg9V4Cn+zpEf
         XFl04LwwFzsvisYG+WDz4Qejp01WwX6mwAaGzAzIV7EEWG+KZxbTEpw9i5V/GSe8LKWo
         9eOw==
X-Forwarded-Encrypted: i=1; AJvYcCVPWhNxOy7o8flARW1xsY9tWreNl96Sz7wzmpowWgFr/SkIM4vbrtOAnygF6AVu68H8F04PPbSrdak3lrzyIfda3FRenIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwB1DVEnY3SHJ1lGaDMzQ8IJhZhU+aNSZju8QxfXUFrjhsjJic
	try2Vh/qnwrvgYHxm7O+zaYlxBnoZs+Fj1B0ynCotr5+pGMW5TRNKGStCWRwz3MiAKOHb3W47BU
	ECGiNJ2HANr/kv5snFiSZUGsIQESaNtHZWuRN6J5mQbdbbU33kZqcF0mRZbs=
X-Google-Smtp-Source: AGHT+IEeCsE/9d5kZQOLQz9zCsrOEREOlk+pn+j4to8gmRcKCXkSndmdjkfK2hAzPunoPRw7+j/ICnzmVVJAh8c3NFUgXCiqR16Y
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1849:b0:3df:3598:7688 with SMTP id
 e9e14a558f8ab-3e1670fc2bdmr7126025ab.21.1752018903099; Tue, 08 Jul 2025
 16:55:03 -0700 (PDT)
Date: Tue, 08 Jul 2025 16:55:03 -0700
In-Reply-To: <20250708231926.356365-1-kuniyu@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686dafd7.050a0220.1ffab7.0026.GAE@google.com>
Subject: Re: [syzbot] [lsm?] [net?] WARNING in kvfree_call_rcu
From: syzbot <syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com
Tested-by: syzbot+40bf00346c3fe40f90f2@syzkaller.appspotmail.com

Tested on:

commit:         ec480130 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17268a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e99b6fcd403d050
dashboard link: https://syzkaller.appspot.com/bug?extid=40bf00346c3fe40f90f2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13fa6bd4580000

Note: testing is done by a robot and is best-effort only.
