Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794716871;
	b=mxErj9p+88aRnqpZxL1SRgd3aO+nTJsyYbuNEUC9VOias0TxobOLmMuuDeMgHNcq0P44
	 s9VN9zseSuwFZyHNk8uvvs7H0h++HSODaQMIuMpnK1P0y7Mr2qA2yBbigMTGlssGkGVyN
	 TJkLwgQLZoWNM/N+WInbpFce5vgN1N83ZjVzWTuPfeH9i9YeNhfy9DfBnHpCaNBjWuwCx
	 GsYJTMjdCN0x3aSweT2jKCv2C1CrPonZOHaXk/6JV43jXz44CQ4+YSTRbWzPEG0FNfGFQ
	 PT3IZpyBDPdn1h0X1bF0NY4x3HEOkicsHUOaOsAun2kFv9Yv+f6xxsrzNGTfL95JUYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794716871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type;
	bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
	b=gefTJXTHvHNNF9+n9zSSdN0+7RXOrpvYy65FIzb5GlESASTV8GEFD+vWIARzAOcOlA1S
	 Wiarh0ZYBhM4OVZe+O3lAw/02A0S8tdx0TQDoSjZaLheUuy8cHiU+xwTtesVpvDvf7kAd
	 BlaB4jt2lgnjRNVN62F8evTO2H8zQy5lxpd74QDBc6nmzh3IGrBiP/FjSj5ogEqQvnleW
	 R4+zw92j6hG/HuBpS7Fak5qH6oSo2hgL+8pUOHj1fdPm6bM/4UdGw9TG6WYnC6wC3TpyR
	 vxntslkkqrY7uZhqw0wYZlWox6bcKYCC0SmXh9aFIJtWgsZwGvbkjZYcP106DKA1cCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrlCOM14;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45624606A323
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 04:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45624606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rrlCOM14
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so3364575c88.0
        for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 20:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794716870; x=1795321670; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=rrlCOM14U7o+M+TZUPRKm/0B5X33KfTWozBYOwW7G1T5mICv5uiTGRDZ8N/E/WkgPs
         Slt3WdfVhPxLW/Dfkkb7/xGjvq8CIoTpYPwhvbdCG6Yvw1BgA2N1EVe8mN0kEHKHXyef
         8tQmPjoZ87TzHMHH5DbiUhIVkAX/fu7oGi34+wAuHuH/TAi5YSfzTR1lg6qENJCTh/vf
         bWlX56f+34OBBzkIC9iYt9wgmDyB8Cq+Fbc85HrZX5UgurcmY8nnkwgd3auzrRPvQadc
         V+9t/jgoM5TmoX0d5ZETJARldRFhGcH0iXCu8yq6U0k0i+/1+kk//+frMRudpsSSkh05
         Ua9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794716870; x=1795321670;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lBVnC2BKavV2mvXAWvVCtFrvsJ4cH4FcPMsK31plLKI=;
        b=yE64s9RO8eyh/cwHwns9nljFQ7IrH8VkHqaVteaJ51QkWWU//bWvL+/WOupgHIXrno
         +j5gU96JyVZ6X2qR8RMvo8et9KJw3WyS7s8g8DHJr4FDJ96tYPXxnnNekiJkDBbvPPbL
         ZoOwHXB5X8lpOl0SypXnGSU8MMuTpiFAuUT7oAjq46t2YXLJaae7c38dWOw5vaSkNRtz
         Qsy6p+UEsB52GOBBkXYRGaw4YaYNCuUtTT2zlYm8x8kyTlqz2jn0pizx7zmpyLw7SjJp
         oX+ECWtljhONDpGx9IWxROpMzidBtNj5avaleAikwJpxtR/7BZ8+o3JyWxpY8yB6jY70
         tNiw==
X-Forwarded-Encrypted: i=1; AL+hErGQuNjNErdxhKtNU9I4qQdQLG8AfMR9n9+faWn8a79Nv9o7/8IPBJoaKZXRxoIUocVCJHmjqDsb7t4ZGYta3Rj1ZqVSpgw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9I2Ypv1ftMXFIdUIi2eLvIKGjnTdbK3sKzLEKXhg4w+cId7ggj
	Ivw8D3uo6oimgGy6HGkHct8/WDhxRDpONV/fjtACFVaZD3b7KYZ4H0Tl
X-Gm-Gg: AYBFou2TuZiOzqX4/7clPRRnIcJTr4EQylWruIb1CP9mWqPOQjP79H7YP/PrlKdpEz/
	8GONO0s6WfWeabPCnkk/aHzvMFbjo9oSXwKCBA9yzTApe0xgow7ZhAlyIhz6H0G8M7lkkD60jZ6
	dfIen+ehJAN33W5BXU17YHQjnQtWfDK7XsZa8bOedO5sCS5kjocY+kUcl8KF5y0SbguwzOdRCz6
	iWkXM6zJBggtDVvFYdtp+EtdX5i9IysyhorWSpcd8i4SbmuuOkb+tlw0NgTM9f8iLd5kI+zSJqD
	6Te5R1/4qcxUseUgVaTQyZ/p1d7ZxunYLmi7D9VN+4+7iqK20JxTktEuhqxUSwhwsUg6VWCISjY
	OA6koM/UW2CotX6RGqA82bTMcT2N8Kcj5MqgCM5ax59hVa5Tf3NisliT3upMzuPjXiaUuvOw/b+
	qQb9WdkwgxjWzS9sXRA+3TiKy6RgSGylNO0DnrTmqmBQ6O+j4dDKyLkd5xT4MNI40OP3rarsTjO
	UNPalvQi23kVtcPLKnZc78Wuo5BtPckQjigHsR6SUmHii/H9NywAombaWHPLAmlrfaLOwKGVAYK
	Bne/XGSp/JWGeHRdJqW63a/RW3Q=
X-Received: by 2002:a05:7300:ff46:b0:37b:c89d:1d56 with SMTP id 5a478bee46e88-37bc89d354bmr1627673eec.12.1794716870280;
        Sat, 14 Nov 2026 20:27:50 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3797f98b9b2sm20640706eec.6.2026.11.14.20.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 20:27:49 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
 <peterx@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry Yoo
 <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang
 <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying
 Huang <ying.huang@linux.alibaba.com>, Alistair Popple
 <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico
 Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Usama Arif
 <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Xu Xin
 <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro
 Falcato <pfalcato@suse.de>, Kairui Song <kasong@tencent.com>, Qi Zheng
 <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, SJ Park
 <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, David Rientjes
 <rientjes@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, John
 Johansen <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, Stephen Smalley
 <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?=
 <omosnacek@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 00/13] mm: continue vma_flags_t conversion
In-Reply-To: <au-DXpEi4wHwsz0r@gremlin>
Date: Sun, 15 Nov 2026 09:50:28 +0530
Message-ID: <7bie914j.ritesh.list@gmail.com>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org> <d0ea7929-7c12-4245-ba3f-6dd5c0269e6b@kernel.org> <au3r0-geuwtRYPiC@gremlin> <1c0b1368-a381-4b25-bba9-7a4f8e92b764@kernel.org> <au-DXpEi4wHwsz0r@gremlin>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Lorenzo Stoakes (ARM)" <ljs@kernel.org> writes:


>> > It's not really all over the place, it's converting vm_flags_t to
>> > vma_flags_t across madvise.c, which involves changing a few function
>> > signatures, whose callers must be updated.
>>
>> Ah, yeah. What on earth does arch/powerpc/kvm/book3s_hv_uvmem.c do with madvise :(
>
> Yeah it's quite worrying that... :)
>

Thanks David & Lorenzo, for pointing this out. I have changed this to
use ksm_disable() instead [1], which then also removes vm_flags_t usage
from there.

Please take a look at it whenever you can. Since it also removes the
EXPORT of ksm_madvise(), I think we will anyways need an Acked-by there.
(note that: looking at those changes, it seems like it should go via
powerpc tree)

[1]: https://lore.kernel.org/linuxppc-dev/0500fbfbb98776091c89584155368610095b4dd5.1794537345.git.ritesh.list@gmail.com/

-ritesh
