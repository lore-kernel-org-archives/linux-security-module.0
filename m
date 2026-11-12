Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461790;
	b=HqZ458Ks35J4kkij7HvnWAotHzqVKk0D+Yvt3d9O+sLxjKsIL4kA3xSfeaQmT8X+DElH
	 Wn+ZMX/Kw9F/RTiO9EOQouN+85DA4p5UxG8/alBXk2W82zK22mFlsNmK6wwV/hQk/cvDA
	 P9P8H3JX+ihyeHhKtPCIbSsN+6oGJ+Te9DA0+GlAPBAt98TpdOE/OXbnPVcyOtLuJIqfq
	 4F1YQxVgshfvs2s+8ZXlNsXFDQwAo4j0HuYmfEbloAyGWTK684WGTwKmG9B6ghFgie1r+
	 rtzCeaV3O6v5QOXuc4PKf9aFj/hwNbjcQT52KVGPu9PsurV18k2AF5ZGOkg1dDl7MXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461790;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
	b=kqdK30m3KbxB+Z1FJ4ft+W5MTzX68m7RakvSWYIK3QHa+wMLxUOGus5KghmcC1Gnal+9
	 cioH7+HSalZ8Z5R8W7Wru4qGTnkklLUPfZpoN+bcDtHe3x5jUbnve/snIP51gae4Qwf5r
	 u8amBeCzoV6U+fn37+jKRdYlf5hifjau31dwLNHbh/pVio6gAh3PV8fQnE6ZPDYZbWMeg
	 owQUYsLY40aJOIYlX6ody57DeV7IbmLdOj8XQRJmgKqCkFBABFK4mhhN28oLh2z71HXnI
	 ffJeEAJVVSHKI/BLdUEIq7R09uuT611PnhqtAGbm7wKrNy52Nizx5yS1W6mBVu6JXkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzLeINlq;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450A7606A885
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 05:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 450A7606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=EzLeINlq
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e55db58cfso352338785a.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2026 21:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794461788; x=1795066588; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=EzLeINlqWKLSrVyAYeG69cub/PpkhXEpvLI85c2/Wn4DBrX36De6eOjOc825yh2/s8
         /BMocYYbFGCIGlSENImF1edskqevAV/Kuf1SeaFnM5vAAp8DG8IO1FgayCsUEWs73OHL
         1RmURtZJc9D4dd17Nf7TyLA18R4yata5cpiLNB4SZ3wXp+wb6mfksV9V6NYOJLevPnzx
         KS0lFdrtd+eUvcxCI5cIGAuAdA3+x/lK/g0n6XOLpuLtAwXE7FSdI5GYz16DwRhEZcI+
         e0xi/xTmcXSNKhZMTs2dmsnafffo4Jcsb0EhR1rdi49ZUTTTqLCosCyqFBij3UK+VNvA
         tckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794461788; x=1795066588;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2soeXJ852281gC+OC2yZSX9G2s4v3lG9pbKt+VP0DM=;
        b=zJLqYiAPz1syOea/3q+ch8CkK/N4LLEHAKtg7zKH8hz0DKbhF/1lV918lY45iLyrPf
         QWELsei7/apyurLscvmLkr2o9qvcDUxKI52DtbpTJb0JTGID2gZdl+gu24AyTxiTrLr1
         IhWUyFTDuZGEnPotC8T/NmXsEiQDtQ/tznREYwtXqHTAqrFlJWelcBh4M6QIOtqaf7aG
         9fRZ3Ah9HI5XXa+aKAeYBbYkC+d7B51eExcTjfhJR29vAmqHp8lJDRKJ1k1BZFbntWnL
         cwge9pdWi2JqMD61EaZfZPdqtBpKTwD3nXO26U9LdM70wilenZWRLaHjMPfIclDuK6Yq
         QztQ==
X-Forwarded-Encrypted: i=1; AL+hErHUlhoPgBtbtrFF5AEA7GciPuGA390TTVgrjEQEAoHMA5UZvJFpiTO8IBKMA0hVufwXzP8uhtJ3g5RHcGiDkxJGyLH9CJY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MvF8C+zQNjSu51MvX0qI+TMsqYxi/6jnQ9nC8R0GIxVov79az
	aB4WX5ioIiIB3pKTED6PhgLEbbEnMr3I9YwACIS69ngXCVDo8xQ9DLMVmF+yPPdKdbI=
X-Gm-Gg: AYBFou0sHFX8Aoi2Q2YnotVMGOHhFo6WCsGlTF8AexVgpBwyMoG+d56oo1Q3A++CbOr
	Twn23SGn9qASy8UEtXwAu8fmkbnigZVRBBOUKAOYYt17U55eAWn9o1A1yNiR7VJwhdy3L02QnZC
	zKmgSpUA5GrWebXKsMsMQY73AbtM8YL9HIbpWWwI7OmfzIwDd++C3noNrsHtQSO9rjfgbyD5Z3z
	WYquhy/5ZMWTN59CKaZUygdF02q0UDGTGls0r4SW2xU1KPCtOBkcjXPvUL3MCCJRKejWeO6rvx3
	HYAz+4OpcmnoBKxvbtopnpRYD+x7vGhBWIOqI/g+13YV0vHnpRjYGbigeSrtj0AqxR+T02nj5nW
	md8MAqyJrWe81nF1ZEstqNs6NJ6SMtTYJaIlgHJO5amjJ9Xvt2Sy2zBQvx6NtnuYK4MoTxY9iCL
	kqEkiyG28+9ZAPrRs/zcY339vSgxNTWbb/ZaT074n/rmq0K64lpI30D7wmf7YnhSGp7YrvrqGD+
	q5k31rfeohTPKC0LOVq1jGTejhDG5pGXlRPGMpwTu7oH2JT6GTHHBYTHsRxnaJ0hckAJzvk/2i9
	ih9ehjffAKHjpDCKLHtGVfi1/sBj/RlXDYyf2bJEw/6VgQqz++Pknvldzwwd8Gq31RC6r92dd/A
	GTRS+7SY=
X-Received: by 2002:a05:620a:4481:b0:93c:c2c2:40eb with SMTP id af79cd13be357-947b0046fb4mr764496385a.66.1794461787830;
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e4fa312sm647786285a.0.2026.11.11.21.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 21:36:27 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 08/13] mm: convert miscellaneous VMA flag tests to use
 vma_flags_t
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
In-Reply-To: <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-8-0d3cd15ab75f@kernel.org>
Date: Thu, 12 Nov 2026 00:36:24 -0500
Message-Id: <179446178440.482102.12362401790016415292.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-05 21:30 +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> remaining straightforward VMA flag tests scattered throughout core mm, HMM
> (and its test module), DAMON and the OOM reaper.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

