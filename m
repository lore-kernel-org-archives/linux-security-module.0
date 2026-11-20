Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.189
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193467;
	b=U3Tl9+mHr9boaYmXaRj1e5eTQhUNkpMKIOQtC858TiYkrfYUavYX1cy2KbtX4VC5GJiw
	 x/5H7m4KWjWjVQ1LSsl3NyGUerTa/uvEqHVcCauRKjufxujYZl74cSbxqL3ltGKri7Y0Y
	 aOB6Cqc6IryBfoXX8qCozZJYxDFetMyhTUwz6rMvJa+Q7oRb4ovhQRPK8gBMf/4efsLHj
	 lgQRpewPrIojhp4UC6kS67aly8t0N1aGAXoKY9VFqsm8YU+rgf5ec0P9vPnyPx7O3HK7S
	 lI0VVc//HsTLHaumiWHDL1cYHyVI67/qZZ4oP+e8wH28V5CN5mjkM1pYQ5gtR3GZ+RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193467;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=K0ndYaDZoYcWVoVC7S2A9Vrq7y6IxfYnkplM3Ym75uw=;
	b=A8TwRy+326ZQCE+UWJdKjCiC0WCVz4vTXkioahLbmCxhm2bl0XoFssza47CCKbe5GGj6
	 oFajbqImaGUpXlVQH7q94nlHywUT6tY4E+ein1XL1ITlmwoV8SnTgq/TJkEAYfB2YvePt
	 56OWkr5XO0hyBu4J6nWstxbOoTTPlQP7dy5kI6xpxBM13SJ27HV1uPXfdyrbxEg5Vb/zw
	 Tqul7+WgWHVQ501ggEhvbHQm9Y2JNAGlojXlKC1N3BRnhYCItfrO1WrcEsMWpMLm03FSR
	 gHkJoknqCFjHtJclyelR7HFopgCPCa7zvuyNlQRXHOboz8p5KvSyt2QINOQH+XCCgrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ey+rgCPF;
	arc=none smtp.remote-ip=91.218.175.189
Received: from mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94C9606A32C
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 16:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D94C9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ey+rgCPF
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=23aotKbVmZZK5ma89rsXnDW+52IBOiyRWRcBtbK9USc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795193464; v=1; x=1795798264;
 b=Ey+rgCPFpVl5X6ujxwbd8djlXrPlNpJW74Q9Z4KSpVywMtwqWC00bkpuKkaJ21q37eCUg3TE
 G5FcnQJOttW75EJOfY4ibCO/3OTnqWDvjZ83K/snpd4bDg0Fi1Bw/fZrFSlF3BXG40dJx5QiTW6
 sO38Nl96M+MORTF06jZorKqg=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2f79ea2b221504db;
	Fri, 20 Nov 2026 16:51:04 +0000
X-Mizu-Trace-ID: 2f79ea2b221504db
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 16:51:05 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>,
 Paul Moore <paul@paul-moore.com>, Josef Bacik <josef@toxicpanda.com>
CC: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, "Andrew G. Morgan" <morgan@kernel.org>,
 Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_0/3=5D_capabilities=3A_close_the?=
 =?US-ASCII?Q?_ways_around_the_CAP=5FSETFCAP_rule_for_uid_0?=
In-Reply-To: <20261120-zutun-ausgearbeitet-erregen-ebd3834404ea@brauner>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com> <20261120-zutun-ausgearbeitet-erregen-ebd3834404ea@brauner>
Message-ID: <167100D4-9E3B-4412-A554-E3D09B5BE9DA@linux.dev>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 20 November 2026 10:11:34 GMT, Christian Brauner <brauner@kernel.org>
wrote:
>On Tue, 17 Nov 2026 19:54:23 +0000, Josef Bacik wrote:
>> v1:
>https://lore.kernel.org/all/20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com/
>> v2:
>https://lore.kernel.org/all/20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com/
>> v3:
>https://lore.kernel.org/all/20261021-b4-setfcap-userns-v3-0-97c7ed4e43e1@toxicpanda.com/
>> v4:
>https://lore.kernel.org/all/20261022-b4-setfcap-userns-v4-0-88aa0ffaa08f@toxicpanda.com/
>> v5:
>https://lore.kernel.org/all/20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com/
>> v6:
>https://lore.kernel.org/all/20261026-b4-setfcap-userns-v6-0-25f10b7ca497@toxicpanda.com/
>> v7:
>https://lore.kernel.org/all/20261026-b4-setfcap-userns-v7-0-bf8a576f7259@toxicpanda.com/
>> v8:
>https://lore.kernel.org/all/20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com/
>> v9:
>https://lore.kernel.org/all/20261109-b4-setfcap-userns-v9-0-0d3f00976ce2@toxicpanda.com/
>> v10:
>https://lore.kernel.org/all/20261112-b4-setfcap-userns-v10-0-84f6f7faa903@toxicpanda.com/
>> 
>> [...]
>
>Applied to the namespace-7.5.misc branch of the vfs/vfs.git tree.
>Patches in the namespace-7.5.misc branch should appear in linux-next soon.
>
>Please report any outstanding bugs that were missed during review in a
>new review to the original patch series allowing us to drop it.
>
>It's encouraged to provide Acked-bys and Reviewed-bys even though the
>patch has now been applied. If possible patch trailers will be updated.
>
>Note that commit hashes shown below are subject to change due to rebase,
>trailer updates or similar. If in doubt, please check the listed branch.
>
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
>branch: namespace-7.5.misc
>
>[1/3] userns: don't let setns() lend CAP_SETFCAP
>      https://git.kernel.org/vfs/vfs/c/711bc24f1d8f
>[2/3] capabilities: don't let ptrace borrow CAP_SETFCAP
>      https://git.kernel.org/vfs/vfs/c/c1e5f4d36d2a
>[3/3] selftests/namespaces: test the CAP_SETFCAP rule for user namespaces
>      https://git.kernel.org/vfs/vfs/c/cbe977960cb3

Oops! Couldn't get to it. I had a look, looks ^Wsane^W

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>




>

--- Thanks!
