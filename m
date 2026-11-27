Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795794929;
	b=wVxPB5v0gLHyrnpDOuLERz3ZcboP0dWQjsSG3w5VcxDzFMym9YpaWJPModrP+vSdyKN5
	 nPADzxKHRE0eLg4Fa/Pi8O3vgQMWrhimpI47dH9QZFcdTP1Qni9HMQrJmtXAvzFuV4TMd
	 810WBL4vM/yBuuiEOCILnUFEfy5XQhRn38fbmwjJ1bOXnL5NTRCjJAbo0dnKfXbM91Gsq
	 aMTmFMK18JnAEG7gcvc3+33/NUSp5KHhkCnOKE/1NWawi4CxH11ouOi2eyxtDPo40rPL9
	 a8H0kqqDXoaChKhkaIzbf62N0F4knb02EGdu4j5sYzxl0nmHnleh9BozxuAVh5y735Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794929;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	b=U+o90Hf3ZSkqXw8xbtU2RLHysm5W6DY2jXM6ch329pEWabGGdydOX4idHU4stSARZuRR
	 ggrbWLiEyQNoe4U54xE801/EagXhSLLrb1Nd/E4HvQBV1HvZRR/wbRF4Zjyu22M+1gXfV
	 QZCR+L/hsp6LU61U4cFRcFof2meCu4nmxQafpxymWa0kq/WAp5Evv+gdKxuxWS0fIsicu
	 uKY2alkaTrNUParAOP8RU66NdVmFFHy7SJ/sNQHUCEoNlNRDFNjRL33QQPqkwPHWgu/av
	 Mn8Z5rSWqhNMnWBIewvWtSO31NKaNa0Q9c6LDfIgMXnUXPVe0nsVr3GDqcnDHK9ALJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9747D606A32E
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 15:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9747D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-862a5ad18d0so8551837a34.3
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 07:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795794927; x=1796399727;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=GzBgmyb1uTOmjGptUt2oBYcS6tJC2UCqW8TX1C+OgV6B/FNOqBv0NYq9l/pbl01O/B
         d4I2d0N4nX7ZYn/NgfkcE/2yzEDRJ4kRJJ5xbTa6w55um4UP+hyXpi1CJSHPTDPuSwRY
         DHl5UUaZxzZznIYJVjT24fAYYbMejpFhvPf0UfAxTfIFJn+ovZyE4YwBEgt5aHDu/nEC
         fbo8BcEnp2leS8dfVN9nk8LtqmEkJzN+Rs1gPnbJyZ0YH2AJTddCjjCol+hcMUhayR6r
         DqAPZ/5UW4++A4+KjQpy6dePJihtgXQwsW6UYVr/kEmk8ieFCuNvZljf/drBaHGZx9O/
         71Pg==
X-Forwarded-Encrypted: i=1; AL+hErGYU8GbFXLgnZ61ItPvMluVHjDuz/UMvpdh0cRDHp21k61PPSJzgM0k7JkLWw+WcvICWQ4al9wwoni/cD8Eck1r3Ui5Kyw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MyE9UMGVY/7fiPpviOmma5wM+9Y98mbdueFIwPgovbdY90m2w
	D0cDvMFG0h98Pi/kkYyOlyGDdsgblMAq0S4MuOJGBob2nClCQnhhbHhz9oW+mgYteq8x6o7gCS6
	NEoASY/Dc0qdZaHhw0r2U0t3q0Zd1XRfCm/leNCBJHWuUsZ1jWEIdMsvQ5Xw=
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3502:b0:4ec:77df:f4b1 with SMTP id
 5614622812f47-57a09e0c7f1mr30072375b6e.25.1795794927619; Fri, 27 Nov 2026
 07:55:27 -0800 (PST)
Date: Fri, 27 Nov 2026 07:55:27 -0800
In-Reply-To: <6a4c22a9.57639fcc.86d58.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b09a7ef.8ccee5ca.1045fd.0273.GAE@google.com>
Subject: Re: [moderation] KCSAN: data-race in init_file / prepare_creds (3)
From: syzbot <syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com>
To: bbnpreetsingh@gmail.com, brads@mainlining.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, sergeh@kernel.org, 
	syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
