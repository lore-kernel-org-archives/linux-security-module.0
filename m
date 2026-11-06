Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944468;
	b=mjY/pUXgxSJwZYl4GuryAJy7ZVeC4XHdYEiHsQhNTPXDwN+0gNeh55OzVTkUax6wKykP
	 4+NmbgIa/GoK4I9R7XPfmMGNPD7aEcQTWqQWxboFd+6Zb2e7yzrE2odYt3Dhszf3fRK/N
	 IpsSydjcEVR74zUAlC+os20g7AuhTw4heF/h1U3/tB3le6jKtjEPibCj84khgV3fDI7IJ
	 bwkZxeHVm1jZLyYOtSMBSVGnPmtdYPjL3fQUPS5a4h3BSNC+h35sOXmOybZP5yMLRdytn
	 ooT62y8X7AJRKN7j7e4Vi5lB0DtwU3NVwZ0WsZfZVM6lS7KxUyKCRC2cAMhoDOYalzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944468;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZkVgJPqUyM/MWdECKVhoMlY0/kmR087+Z++BChEE7DA=;
	b=4TO5Ap7LXdBJjlU/ReErZTC89ordcPuULAx99z1iCE6tIEDJd6qBbx2gZCaNXr4JCT3h
	 gFchjo1oeYmgDfGEDE009GD3X2R6o5/ykm3NY0T+U59GGvBwNyoR+08B/v++s8Sj+lyef
	 FxYWp0+B2HovoAc+SA6yWtVMEFbS7iHPbHo0DjM//f2DdNuVpnwnXft/10WH2IXXDHdwR
	 OlSym2/p1GGvCRr932wVyAHPEAtqgEeyYIj1nt5K6HcYuIk9+/n/7334osMULPJNExG8Z
	 mAeCHuASdZJ2bFlGg8Pxbz7KtVB6XxfzvBjz+uesfl+kpBEJEgww4pOUowI/LnhHOPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XM73R6f9;
	arc=none smtp.remote-ip=95.215.58.87
Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C71B606A32C
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 05:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C71B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XM73R6f9
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZkVgJPqUyM/MWdECKVhoMlY0/kmR087+Z++BChEE7DA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793944465; v=1; x=1794549265;
 b=XM73R6f923jyC0PZNUyIeEFMqCmB2nWVRY4vtPYRgmagU8XrWDY7HJJLfj60oHRnUklclkrW
 8fpzquZt131BMUCZMDzlV7vXYXOvJjD0VgcEJK8HEYBBufNfV/c/nfxM5lCVTm6pt7vbauBgM8J
 J57tKB77ylquFvNEhY9WOQD0=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 578f26654fbdc28a;
	Fri, 06 Nov 2026 05:54:24 +0000
X-Mizu-Trace-ID: 578f26654fbdc28a
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	willy@infradead.org,
	jack@suse.cz,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	usama.arif@linux.dev,
	kas@kernel.org,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	maddy@linux.ibm.com,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	pfalcato@suse.de,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	leon@kernel.org,
	sj@kernel.org,
	rakie.kim@sk.com,
	rientjes@google.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	mhiramat@kernel.org,
	oleg@redhat.com,
	john.johansen@canonical.com,
	georgia.garcia@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	wufan@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnacek@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: Re: [PATCH 03/13] mm/rmap: convert remaining VMA flag tests to use vma_flags_t
Date: Fri,  6 Nov 2026 13:54:15 +0800
Message-ID: <20261106055415.42873-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-3-0d3cd15ab75f@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Thu, Nov 05, 2026 at 09:30:54PM +0000, Lorenzo Stoakes (ARM) wrote:
>Replace the remaining uses of the legacy vm_flags_t flags in the rmap logic
>with vma_flags_t values.
>
>No functional change intended.
>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Reviewed-by: Lance Yang <lance.yang@linux.dev>
