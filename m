Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450CB38D016;
	Fri, 22 May 2026 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486824; cv=none; b=rTdWQfQR2whYIMAHAH0rzUGhL20ldIbofWD0ZgDlhNUDn9KvoqCIELdfuwxAuiq+wD0aSSTD6QZdllyGJVaF1JwBKRrtDs9GE4FoOSmV7Y8tHPs24st69Y9FHNsNvQvn0IJvw8mevuWb5D+iqYpZXd1l86YM5c0MyGEwoxVuV88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486824; c=relaxed/simple;
	bh=N4Xu6zaP4s6pTGJBAl+fSxqyq/o/h10PLOYcLGxbok0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aACQ8qbJ6FAFd+B7Sg/yM4k2EOoXvODRCITO8WNU8Oq0CC1mQMWgD1niKUOUGXoVT2JexA3DTCjGcuKpv2+cnfzwWv0VrGBmkQNlqgxcXVap37tFurc68sct9NJVZK8t9xA59CH7OvUpnUSwMXSfBxn6CEBIkyLd9QE0KCtBdzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD0N2yOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD0N2yOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B448D1F00A3D;
	Fri, 22 May 2026 21:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779486823;
	bh=mViyFG8r0M8DkkTrfo/F7n2l6DbuPixZapWCdej1BTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JD0N2yOYknpVYTxf6pSExPENIY+QRcf+gKndDSTZWN3YKJ7f2pXFDpi19DL6fAlxV
	 aVF9+QZnzsDH3eqinhiQ19YZg93DXKEKaUNvmzbfPTgHdb9gaDB55lrEWeJr3fWisK
	 WaW9EDEhFqsbMjtBR8GmL6pHzNNBETYMkBygqt+pEkD83S4tLrSqwvfpCjNKU5Hc9B
	 2Eorrvc7S6hQRSIfQFyUkuYGLsFmWezm5a+zPUJYCjMDSonfbO/CasVp2ytQoiQp72
	 0a5UJjc1TK9ATBbzv7RjXI4lRT86WHjoSh1ErehEBJ+/Rm1ECxxWTr1hfHPUOWsQBi
	 sk+L9joMFwV6g==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf v3 1/2] libbpf: fix off-by-one in emit_signature_match jump offset
Date: Fri, 22 May 2026 23:53:36 +0200
Message-ID: <20260522215337.662271-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522215337.662271-1-kpsingh@kernel.org>
References: <20260522215337.662271-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The offset for the cleanup-label jump is computed before the MOV R7
instruction is emitted, but the JMP lands after it. Account for the
extra insn in the offset calculation (-2 instead of -1). Drop the
redundant self-loop in the else branch; gen->error = -ERANGE already
marks the generation as failed.

Fixes: fb2b0e290147 ("libbpf: Update light skeleton for signing")
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/gen_loader.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index cd5c2543f54d..9478b8f78f26 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -592,13 +592,12 @@ static void emit_signature_match(struct bpf_gen *gen)
 		gen->hash_insn_offset[i] = gen->insn_cur - gen->insn_start;
 		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_3, 0, 0, 0, 0, 0));
 
-		off =  -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1;
+		off = -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 2;
 		if (is_simm16(off)) {
 			emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
 			emit(gen, BPF_JMP_REG(BPF_JNE, BPF_REG_2, BPF_REG_3, off));
 		} else {
 			gen->error = -ERANGE;
-			emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
 		}
 	}
 }
-- 
2.53.0

