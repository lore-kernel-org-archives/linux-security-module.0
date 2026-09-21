Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F04E13E9
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010053; cv=none; b=X3jHpGuZSD4JCTv5b9s64mfteOTigUBIVzCR0LYFnAAaboFFX906GBcRZ3mOMDcMfIySFJhSy6huHq5gstR7zSdNULMNVn084lBCTR+wZ+P6GJIr33j9ya/kH5j7sg1yecnPCggGdh6MKAVxpeCWjhQEgkXaOp+P5jzKcMIHfXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010053; c=relaxed/simple;
	bh=hK+61oik5gsxN96IHn3CnokMCdTIaajwpmg47B7x+JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ro9+DJeXfoIyMHqVmkpSkD+fH06j+sU4o8+8vf0BiyQfO8REnnksHHdTr9l0lN3mDCtMEHNMRFL8a8pNcrAgnKJlmy8Dg+S0Y2+cMpDPnkoIpK8wmi4XSSDeS8sBilvoS3U0PjrUa9to9hmsfXzPXJsc85AbvbI/IugixZi0v+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c1b8d7b5so2492884e87.0
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 10:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010050; x=1790614850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hK+61oik5gsxN96IHn3CnokMCdTIaajwpmg47B7x+JA=;
        b=mxOqdK5Gb3ZOlJPfzlqa4EnJYmGvuUYo5mSxtxRi+LIwl6eLT8Rvw0no0tTV/16mM6
         /crlcSeIj2go3kBTguX+Xwldu58fyvxFaZvsn8YpkaiseN//0GdqhVPjQeuWmQ7+UlzD
         0DMmxt+Dbs0SBlObT9xel43TxqnGp2YAy6eYaZY7NcMd97j7z2htZHePLpu7YzWTE6XJ
         MQT093UHCN4e3/j2AiRRaoKnRXKJt2gMGQFU7+6xm8yAKeTu3tadqcDMK7S9kFaTGkfC
         ypDx+5n0DRhag4wnRTv2Ppai5H0RHU05anyv+EuTmgzerto9J/ep5QAc2NzW1IBeZu0U
         yheg==
X-Forwarded-Encrypted: i=1; AKwUvBxZtzwwyl9/TlfKF0f4R1rRxPJiuBbvP+95f6haIZLiOkjtpVI41qPIpOrfGMSGEm9NsE6pDXNqP+U4cQOVSUziCvhRCXg=@vger.kernel.org
X-Gm-Message-State: AFuF++nuOw1155GCbBzVpgMQr0N4s/TKjyEJN31KoZKTf1VzG7q9/0dC
	ubYJ1ICIu0XaZNqz/6NIpfaj1O85Th/vYb8qkRTPqI9jIwiCYIPpjZXvHA4ThxhonoIrJg==
X-Gm-Gg: AYBFou3t1tty8AZnuxA7vVPabh76yFmk6+mmO2JtHKkDHKG74KEqKtjrP/iKjqNoDhG
	wRYvFexs6/MWyTRByvGDf2SuJj6GjC4Lim3LB5iWAg2eb0pQHXPMBfoHiPnJX3sOt07to7Pn++J
	MDtDUxTIvlyeSf6PgtMkGkC0YCo7LZmVZnfCDz21SUP8FOnXaIw5QICkomdoQd+2qmpyHWyBUI3
	R+X+jRHpG3e4Bypahsy6K6fkCFlUVDo8vIHCQ6+t3xiH/65GOWNInkzQMLmeZFv3IruKiw5T1jB
	ktCkfoD9G2F99i4IPGfOaaiT85wpMkiAkOQnrJ6D6yqy+8p/TzVrLlMKPn2XZOCkgON6h/zIC01
	/oq1MnV/pCW3zHIp31xdFXVysK7JWV1f0nnpWRYyJjx8ABxZWpOcgzq6NqIaVSST+YhmUE0J1IQ
	RZXU94V54eJrkvOpwciB43X7Lri6HqeFuDFBaZjj65wq6VXf4QSm57xVIzd9X//pwPIcVuNTH8x
	MQuxsxGF7wqnoReDhy1wTlZcXX6GWXRF5avn1z5juX7WwuMXnTcKWMT/bHADwU=
X-Received: by 2002:a05:6512:1389:b0:5b7:6489:37c7 with SMTP id 2adb3069b0e04-5b8c179d8cdmr3513670e87.0.1790010049753;
        Mon, 21 Sep 2026 10:00:49 -0700 (PDT)
Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com. [74.125.230.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c78c11d6sm2180756e87.2.2026.09.21.10.00.49
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 10:00:49 -0700 (PDT)
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d5bso26365831fa.2
        for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 10:00:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw8uXUxrq8hhQyz1bR5eC7cgnf1a9IMKoOQ4w3jtpxCE9Gjl6OUmEAh8igAGqQU42W6bLWPHGlbRQgJWVtcp/nWn0C3SwQ=@vger.kernel.org
X-Received: by 2002:ac2:4c4e:0:b0:5ad:55f6:1ec3 with SMTP id
 2adb3069b0e04-5b8c181f45bmr3718755e87.5.1790009663874; Mon, 21 Sep 2026
 09:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn>
 <lhuecf9cbl8.fsf@oldenburg.str.redhat.com> <CAC1kPDPu41RxMLHpPtz4VqfkEZeu-fYXG76XVZMh8bbQa3okaw@mail.gmail.com>
In-Reply-To: <CAC1kPDPu41RxMLHpPtz4VqfkEZeu-fYXG76XVZMh8bbQa3okaw@mail.gmail.com>
From: Chen Linxuan <me@black-desk.cn>
Date: Tue, 22 Sep 2026 00:54:11 +0800
X-Gmail-Original-Message-ID: <CAC1kPDMCFoVsPDZgoCF6mHqHQafCkDc3Pohpp6pNOLJzE2OTYg@mail.gmail.com>
X-Gm-Features: AcwNN1U1zJ5xAFsdo7eYagPVPgcyEU2aovVJcIoR_uPclCIazBY4PYSmw97k5Co
Message-ID: <CAC1kPDMCFoVsPDZgoCF6mHqHQafCkDc3Pohpp6pNOLJzE2OTYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfd: add task path ioctls
To: Chen Linxuan <me@black-desk.cn>, Jann Horn <jannh@google.com>
Cc: Florian Weimer <fweimer@redhat.com>, 
	Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jann,

Christian suggested adding you to the discussion on this series.
I sent a follow-up reply with you, but I=E2=80=99m not sure whether it
reached you.

When you have a chance, could you please take a look at the thread and
let me know if you have any concerns?

Thanks,
Chen Linxuan
