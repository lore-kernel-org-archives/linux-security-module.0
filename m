Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.237
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794753923;
	b=2NOjcvfBr8uJBq3UBrcGbUNDnR7rafdHaH1bUvSNoNGqRWBWKoc/ChcYfWMq+MC0dkim
	 mkrzAPD0RRymQLGqpbqVnmbs3dWEqfm9127rIiZR8lH8mLd2TjBzX8IKM1VTc5h/qRBGl
	 awvCdOARkVzKWPT+x/eb14YP0pSK9BeNP3bBUKW4umA/q4GCL57VFEGY4GySGX/k2GOYm
	 pU/JJUT/afmt1URR6DlA8e1LPrf1RTtFSg1TSq1kXAc8ubda4pkk31k4ypX8a1X4YVZ+Z
	 H0NK7SHyON/sb0NcY64cm5zLNRepsMbRhL/089ofxLmYUX/R0UU9iVaCIcG4xj56Jbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794753923;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8/WotbWDHEfmRfuiPjuZcwLPMvVS6lQVakAC3VWoLLU=;
	b=MJc8pdd4XwM1kt4Pu14vZcQ9lsqsmsSkY7ykuwmFdS6PHOzd9+5IBGLG5YrvZHan/fNo
	 Acm7XzDzgnr2Vkc44Lg9mk1EX2w5QhYMp/ODIb4F8hQ5r3P33ZYSjlG3EGhFX3QGfnd+r
	 G4P1CuyIr88U1FDDdlLm9WgfsEfKU62M0MfuqMQaRjSe+JY8ZMlfrZ7T0u64E8wWPDOMB
	 zXLn5tD8uzC7uctYuN5++0BdH1/8KYfxpV9Cjzc27G7RH1ELQCibK6W1yBJqezFucLDQb
	 rh5BMr+c/klWw3FUPgnLJqdOlVG4cV2D7BoasMPbWHDeQTtFQy6dvsQbLPsbiPAGZMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vqAncgoc;
	arc=none smtp.remote-ip=91.218.175.237
Received: from mta0.migadu.com (out-237.mta0.migadu.com [91.218.175.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BAD606A31F
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6BAD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vqAncgoc
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Lampe3FcPP1WTHHlXMYUS2tntnZofTfaiYWl5Mu2ONA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794753920; v=1; x=1795358720;
 b=vqAncgocWriTzN0GQwLHVQzHJz9ZyGwRHciDgSVGrOZmnN9Pnuhcn6ShMrI+TC7raS3ddDsy
 Z7mysgH/KHoVoUX9nSHVH7CfPqwY24q2bJXtNH7gmzHt2z2krPt5u4DsjHuXggkJtCq2oaTqnf+
 chCbM5oRd0bbNCTvnFhE2Gi4=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5fc379baf2e39b51;
	Sun, 15 Nov 2026 14:45:18 +0000
X-Mizu-Trace-ID: 5fc379baf2e39b51
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	paul@paul-moore.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Huw Davies <huw@codeweavers.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ipv6, calipso: fix data-race in calipso_cache_add() bucketsize check
Date: Sun, 15 Nov 2026 22:45:07 +0800
Message-ID: <20261115144508.71543-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue found by sashiko when reviewing my data-races patch [1]. This is
not a plain READ_ONCE() annotation like the rest of that series but a
real fix, so it is sent separately.

calipso_cache_add() reads calipso_cache_bucketsize twice: the "<= 0"
guard on entry, then the "size < bucketsize" test after taking the
bucket lock. A writer can flip it to 0 in between:

  CPU0                                    CPU1
  calipso_cache_add()
    calipso_cache_bucketsize == 10 (> 0)
                                          proc_dointvec()
                                            calipso_cache_bucketsize = 0
    spin_lock_bh(&bucket.lock)
    size(0) < calipso_cache_bucketsize(0) -> false
    -> else branch, but the bucket is empty

On an empty bucket the else branch takes list.prev (the list head
itself), list_del()s it and then list_add()s through the now poisoned
head:

 Oops: general protection fault, probably for non-canonical address
 0xdead000000000108
 RIP: 0010:calipso_cache_add+0x2f0/0x380
 Call Trace:
  <IRQ>
  calipso_cache_add+0x4c/0x70
  netlbl_cache_add+0x4a/0xa0
  selinux_netlbl_skbuff_getsid+0x1ac/0x280
  selinux_skb_peerlbl_sid+0x7d/0x100
  selinux_socket_sock_rcv_skb+0x2d3/0x460
  security_sock_rcv_skb+0x86/0x150
  sk_filter_trim_cap+0x56/0x730
  sock_queue_rcv_skb_reason+0x1e/0x80
  rawv6_rcv+0x679/0xb20
  raw6_local_deliver+0x1f0/0x5b0
  ip6_protocol_deliver_rcu+0x215/0x9a0
  ip6_input_finish+0xb0/0x1b0
  ip6_input+0xa8/0x250
  ipv6_rcv+0x14b/0x1c0
  __netif_receive_skb_one_core+0x8f/0xe0
  __netif_receive_skb+0x23/0xb0
  process_backlog+0x27a/0x950
  __napi_poll.constprop.0+0x61/0x2c0
  net_rx_action+0x372/0x800
  handle_softirqs+0x109/0x570
  __do_softirq+0x10/0x18
  do_softirq.part.0+0x47/0xd0
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0xf0/0x120
  __dev_queue_xmit+0x578/0x23f0
  neigh_resolve_output+0x278/0x3c0
  ip6_finish_output2+0x4b1/0xcb0
  ip6_finish_output+0x2b6/0x6b0
  ip6_output+0x122/0x400
  ip6_local_out+0x61/0xb0
  ip6_send_skb+0xa0/0x260
  ip6_push_pending_frames+0x2b/0x40
  rawv6_sendmsg+0x1b7a/0x2750
  inet_sendmsg+0xa1/0xb0
  __sys_sendto+0x2fe/0x350
  __x64_sys_sendto+0x7f/0xb0
  do_syscall_64+0xe1/0x450
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Snapshot the sysctl into a local once and use it for both tests, like
cipso_v4_cache_add() has since commit dd44f04b9214 ("cipso: Fix
data-races around sysctl.").

[1] https://lore.kernel.org/netdev/179428999963.994134.16904544500890053668@kernel.org/

Fixes: 4fee5242bf41 ("calipso: Add a label cache.")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/ipv6/calipso.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index e399a42e3083..fb79eccafc02 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -263,13 +263,14 @@ static int calipso_cache_check(const unsigned char *key,
 static int calipso_cache_add(const unsigned char *calipso_ptr,
 			     const struct netlbl_lsm_secattr *secattr)
 {
+	int bkt_size = READ_ONCE(calipso_cache_bucketsize);
 	int ret_val = -EPERM;
 	u32 bkt;
 	struct calipso_map_cache_entry *entry = NULL;
 	struct calipso_map_cache_entry *old_entry = NULL;
 	u32 calipso_ptr_len;
 
-	if (!calipso_cache_enabled || calipso_cache_bucketsize <= 0)
+	if (!calipso_cache_enabled || bkt_size <= 0)
 		return 0;
 
 	calipso_ptr_len = calipso_ptr[1];
@@ -289,7 +290,7 @@ static int calipso_cache_add(const unsigned char *calipso_ptr,
 
 	bkt = entry->hash & (CALIPSO_CACHE_BUCKETS - 1);
 	spin_lock_bh(&calipso_cache[bkt].lock);
-	if (calipso_cache[bkt].size < calipso_cache_bucketsize) {
+	if (calipso_cache[bkt].size < bkt_size) {
 		list_add(&entry->list, &calipso_cache[bkt].list);
 		calipso_cache[bkt].size += 1;
 	} else {
-- 
2.43.0

