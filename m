Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D87347FEE;
	Thu, 21 May 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376945; cv=none; b=hQUp4L8sYyKmRnpm2ITkd+PvpaIz2Sh72s5Ja3oNsiqiP8mnnHjhM4MKJkyk39VdICCX4qZGz6yg8+2jdAnNQCKw5bRtj80S7NPE8wBsylLUyA2CEWljmKq8ynptabTGvG9c8jKVK5t+2If1R6+Hahma+SCBpTQ/6MyYNPfm2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376945; c=relaxed/simple;
	bh=N4Xu6zaP4s6pTGJBAl+fSxqyq/o/h10PLOYcLGxbok0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6mzcXxsCnTilHwoj/GWs7oWEvF2McZacvCsy7n1nfV8CTPgvZZ3VBabl+2Me7Ga3PZAAMiuesMUrrmngTsf4r0mjDx5Es8wVPWN39A6RsCiYBPlCv+UUCQIGTfqgylP4aJBKcesigoIyGsfNVXevUjArDnThxzQIIQ1Wrh7+mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxSquLqM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxSquLqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC191F00A3C;
	Thu, 21 May 2026 15:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376943;
	bh=mViyFG8r0M8DkkTrfo/F7n2l6DbuPixZapWCdej1BTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dxSquLqMG6SAIv3GMR84CcwaAPTB4NZJJ/CdLfJVC+5zh9HFYEz0NEESvckRGnOs8
	 gSZkwsLB5zLxeKIfAZuhvs/YSxgrO0wOTT2c4mF0bAg667+nejkIrl/Z3/5IRPyo/8
	 9bH/bfSvtbhrqUunXqU5UuI5UrYtBFjWToaIP4drIXmE5dVYR6UMLhvao4Cx6adqFp
	 W2mMsGM9ZzfGLY7VyOeuKx3ja1r0pWnP0VJxwX3QjFW7nAu5kpB/3W/9jEH0P/AlKQ
	 4I5FXmWCyOa6dEg6QT4316QKKZj17YKRmykvlmdnoOPysM87UAOSYVS18tbq1pUuRz
	 BlN1aZU6dk0yg==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v2 1/2] libbpf: fix off-by-one in emit_signature_match jump offset
Date: Thu, 21 May 2026 17:22:16 +0200
Message-ID: <20260521152217.2345235-2-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521152217.2345235-1-kpsingh@kernel.org>
References: <20260521152217.2345235-1-kpsingh@kernel.org>
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

