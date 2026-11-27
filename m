Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795745442;
	b=LevTjIz+Yue10iSpiX1g/z/cv5iC3iKo1OcU8TJs4eHfIpm2FtvbwIpRyasNq9n8oqq3
	 OJTEjFF4WY85hOsx5s0Cd3HkSunixdK0WFpiNxvqVWlQii3KH0QEQOHLDgYU3n5cjZ0Hj
	 SUZcxld6IF2ZzlPP6XtbzTbQVjiY7oF2y3B/dnUkDhemPD4kRfpNJMVcBPPY09auOCtp3
	 p3o7NvmOwhAGU5BsS1QrcOxidP/7wp0rVT9ZPohprXfgL4aDntqjKyo7DI7Eh8nspyW4j
	 Pm3H2Z4yTKh92LAE5ArEAqI83UdDVYBBk3lQR00k3ImDjFgoijH1JAp6kC6otfbEoVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795745442;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bO/W1h7ZD8/sZ8hK6m5Vq3d9fFeTUqLDBboZRe/aGTQ=;
	b=wN/XH0JXBUaU4yGgAnfrc5EmymwxW6GBuHBKWDdp6u9t36bV7TI677O0MKD8tXuSIw3a
	 2PSx/PdPX3EyLx5Mp3VQubHyLV0MJ7ekrUgrHLilLi8UrfJjIAhdY+UuMn3TFkucEno+y
	 BOXxlrkyWvG9HFMMlqf+dSDpIBF3YMmW2HAflYOUhBDjXAmKW7UGNvRm3G9toaSho92DE
	 NMl9MPFcaK4ba8lIVUzQribYptpjt0H5bCCzjXnHkvINTeZ2+95A3oQHHLMTIuLGajIxv
	 AHe+AXfXYu/zIzngzMHYHkWhXXrx7AtbAJycbPlWsMW0RvJDclXfYN+InaPwxF2+X9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B16606A321;
	Fri, 27 Nov 2026 02:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2B16606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b96e8d42ea0711f19a56ed5b684f684d-20261127
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a3a60f6d-ce47-4618-83a3-085355a49b31,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.19,REQID:a3a60f6d-ce47-4618-83a3-085355a49b31,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:7db8b62,CLOUDID:0a688e5116bb59d072e94ff420795ed2,BulkI
	D:261127101034AZDMAGJK,BulkQuantity:0,SF:17|19|38|64|66|78|80|81|82|83|102
	|127|136|153|841|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:-3|-100,IP:
	-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b96e8d42ea0711f19a56ed5b684f684d-20261127
X-User: maguicai@kylinos.cn
Received: from localhost.localdomain [(36.106.123.207)] by mailgw.kylinos.cn
	(envelope-from <maguicai@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 497214400; Fri, 27 Nov 2026 10:10:32 +0800
From: Guicai Ma <maguicai@kylinos.cn>
To: Cai Xinchen <caixinchen1@huawei.com>,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	shuah@kernel.org,
	kalevi@kolttonen.fi
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	lujialin4@huawei.com
Subject: Re: [PATCH v3 8/8] selftests/lsm: add lockdown securityfs test
Date: Thu, 26 Nov 2026 21:10:29 -0500
Message-ID: <20261127021029.2562038-1-maguicai@kylinos.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126131315.1256553-9-caixinchen1@huawei.com>
References: <20261126131315.1256553-1-caixinchen1@huawei.com> <20261126131315.1256553-9-caixinchen1@huawei.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Thu, Nov 26, 2026 at 09:13:15PM +0800, Cai Xinchen wrote:
> +run_lockdown_test: all
> +	$(call RUN_TESTS, lockdown_test)

As Sashiko noted, out-of-tree builds fail here because the binary lives
under $(OUTPUT).  Running with OUTPUT= set produces:

  # Warning: file lockdown_test is missing!
  not ok 1 selftests: lsm: lockdown_test

Using $(OUTPUT)/lockdown_test here works both in-tree and out-of-tree.

> +	if (geteuid() != 0)
> +		SKIP(return, "requires root");
> +	if (status_writable())
> +		SKIP(return, "cannot open %s for writing: %s",
> +		     LOCKDOWN_PATH, strerror(errno));

Having both checks in FIXTURE_SETUP() makes non-root runs skip
read_format as well, leaving the 0644 / open(O_WRONLY) EACCES behavior
documented in 7/8 uncovered.  Moving the write/root gate out of
read_format (or adding an unprivileged open() check) would cover that
part of the ABI too.

I also ran the lockdown_test binary under QEMU/KVM on arm64 (mainline
9437ee8b6cf6 with this series applied, KASAN + lockdep,
CONFIG_SECURITY_LOCKDOWN_LSM=y).  Under lsm=lockdown, uid 65534 skipped
all 5 cases, while root runs passed none -> integrity (5/5),
integrity -> confidentiality (5/5), and confidentiality (4 pass, 1 skip
on upgrade).  Booting with lsm=yama skipped all 5 cases on ENOENT, with
no KASAN or lockdep warnings.

Thanks,
Guicai Ma
