Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17DE3F23C9;
	Mon, 31 Aug 2026 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178039; cv=none; b=aMv/cUG2rtKVUNOc8VTf3jHtVwIoraod85uvA3PuzKRfKIenpta/9go1wO5Z2moakpoUEZhAH5JfXWY6YiDf8/0BCKqhcDUkeay3asrQFH2x1waNQqw1+tPAl5iWVoojVlOU4b1q5jZJSXyigCdCaFAhENIdYc6BweQ7rbNIkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178039; c=relaxed/simple;
	bh=psZy7dbAzXBstHDfITN0TvFphDtTgH1CjONmrutXaFs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=WsjDe7YhNFg83aIv9SXqoRdUSVjs0T6QrojEtiJsUqRMXR92mE45EPrDXEiW7PKQvcNY2KpqlEIluip1Fo17XIS4ZzIn8xraj9VyVAUC2s/O9dgLki2f/v/muq3Q/cLx7CGL83TWw13gOodabix2K2trlFc7gWJFyClDWJSNzUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecPradol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecPradol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E7E1F000E9;
	Mon, 31 Aug 2026 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788178037;
	bh=sxITRdGiF8nNWQ9sU3tcJFxWc59k0x7Qgm3VdJgoXxA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ecPradolzv9wv9ndrTlxPeCPt2bWWCqktsFBC2ZGksVrWIwjMZOHEV41eWGNywmJo
	 b6RksXhkLVnfiSQiZo1aAtiwrcEGp9S3UNqUOOsPUnt54AcDJcQ83sRHf52wesAgk6
	 tSxLLAVW3qTK0APPOJdIE28beWgNd/gRnh4vvwEzwci5k4LzA4mAwdgwUDwl31zTNl
	 pOSbn2Yu42V8zooVF8AXt7ySmy4dzLESDAd9eVFryq0NpkyqvyEANsnd94FJaOnhKE
	 iE7/VvpYnAhwEIuQVIcI5cTeh5osaEJxtr/0GpiFGeRwDNs3zyt6+zWEwl7S5ZZmBs
	 9D554fXAKcg8g==
Content-Type: multipart/mixed; boundary="===============6103159406767288039=="
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8d30ab031e47894c8309a8f6d8c054ead8123f9228ce6f983fb3c951e46bade9@mail.kernel.org>
In-Reply-To: <20260831110934.241898-8-a.s.protopopov@gmail.com>
References: <20260831110934.241898-8-a.s.protopopov@gmail.com>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Add tests for BPF ethtool hooks
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,bpf@vger.kernel.org,linux-security-module@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,kpsingh@kernel.org,matt@bobrowski.net,john.fastabend@gmail.com,brauner@kernel.org,paul@paul-moore.com,torvalds@linux-foundation.org,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 31 Aug 2026 12:07:16 +0000 (UTC)

--===============6103159406767288039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     This is how the list off sub-tests maps to call sites:
>
>       linkstate_get_doit:    netlink.c (ethnl_default_doit)
>       linkstate_get_dump:    netlink.c (ethnl_default_dump_one)
>       cable_test_act:        cabletest.c (ethnl_act_cable_test)
>       cable_test_tdr_act:    cabletest.c (ethnl_act_cable_test_tdr)
>       features_set:          features.c (ethnl_set_features)
>       module_fw_flash_act:   module.c (ethnl_act_module_fw_flash)
>       tunnel_info_get_doit:  tunnels.c (ethnl_tunnel_info_doit)
>       tunnel_info_get_dump:  tunnels.c (ethnl_tunnel_info_dumpit)
>       tsinfo_get_dump:       tsinfo.c (ethnl_tsinfo_dump_one_netdev)
>       rss_get_dump:          rss.c (ethnl_rss_dumpit)
>       channels_set_doit:     netlink.c (ethnl_default_set_doit)
>       ioctl:                 ioctl.c (ethtool_bpf_ioctl_hook)
>       ioctl_sub_cmd:         ioctl.c (ethtool_bpf_ioctl_hook)
>       no tests:             rss.c (ethnl_rss_{create,delete}_doit)

The changelog's sub-tests table does not match the sub-tests the patch
adds. The code registers 15 sub-tests, including cable_test_phy_index
(check_doit with TEST_PHY_INDEX, exercising the phy_index argument of
the doit hook) and strset_get_phy_index_dump (check_dump with
TEST_PHY_INDEX, exercising the phy_index argument of the dump hook),
neither of which appears in the 13-row table.

These are the only two sub-tests that cover the phy_index parameter at
all, i.e. the least obvious part of the new hook ABI, so their absence
from the mapping is the part a reviewer is most likely to want
documented.

Two smaller inconsistencies in the same block: the prose names
ethnl_tsinfo_dump_one_phydev() as unreachable via netdevsim, but the
'no tests' row lists only rss.c (ethnl_rss_{create,delete}_doit); and
'the list off sub-tests' should read 'the list of sub-tests'.

> diff --git a/tools/testing/selftests/bpf/prog_tests/ethtool_lsm.c b/tools/testing/selftests/bpf/prog_tests/ethtool_lsm.c
> new file mode 100644
> index 0000000000000..f4662fb1ae3ce
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ethtool_lsm.c
> @@ -0,0 +1,330 @@

[ ... ]

> +static int ethnl_request(int fd, __u16 family_id, __u8 cmd, __u16 hdr_attr,
> +			 __u16 extra_nest, __u32 ifindex, __u32 phy_index, bool dump)
> +{
> +	static __u32 sequence = 10;
> +	struct genl_req req = {};
> +	__u32 seq = sequence++;
> +	struct rtattr *nest;
> +	int err;
> +
> +	req.nlh.nlmsg_len = NLMSG_LENGTH(GENL_HDRLEN);
> +	req.nlh.nlmsg_type = family_id;
> +	req.nlh.nlmsg_flags = NLM_F_REQUEST | (dump ? NLM_F_DUMP : 0);
> +	req.nlh.nlmsg_seq = seq;
> +	req.genl.cmd = cmd;
> +	req.genl.version = ETHTOOL_GENL_VERSION;
> +
> +	nest = addattr_nest(&req.nlh, sizeof(req), hdr_attr | NLA_F_NESTED);
> +	if (ifindex && addattr32(&req.nlh, sizeof(req), ETHTOOL_A_HEADER_DEV_INDEX, ifindex))
> +		return -EMSGSIZE;
> +	if (phy_index && addattr32(&req.nlh, sizeof(req), ETHTOOL_A_HEADER_PHY_INDEX, phy_index))
> +		return -EMSGSIZE;
> +	if (addattr32(&req.nlh, sizeof(req), ETHTOOL_A_HEADER_FLAGS, ETHTOOL_FLAG_COMPACT_BITSETS))
> +		return -EMSGSIZE;
> +	addattr_nest_end(&req.nlh, nest);
> +
> +	if (extra_nest) {
> +		nest = addattr_nest(&req.nlh, sizeof(req), extra_nest | NLA_F_NESTED);
> +		addattr_nest_end(&req.nlh, nest);
> +	}
> +
> +	err = genl_send(fd, &req.nlh);
> +	if (err)
> +		return err;
> +
> +	return genl_recv(fd, seq, family_id, dump);
> +}

ethnl_request() never sets NLM_F_ACK, so a doit request that succeeds
without producing a reply message gets no netlink response at all:
netlink_rcv_skb() only calls netlink_ack() when
'nlh->nlmsg_flags & NLM_F_ACK || err'.

This is exactly what happens in the allow arm of the channels_set_doit
subtest. ETHTOOL_MSG_CHANNELS_SET is dispatched through
ethnl_default_set_doit(); ethnl_set_channels_validate() returns 1 on
netdevsim (both get_channels and set_channels are implemented), so the
hook is reached and the deny arm works, but the request carries only
the header nest, so ethnl_set_channels() takes 'if (!mod) return 0;'
and the SET handler produces neither a reply nor an error.

genl_recv() then blocks until the SO_RCVTIMEO set in genl_open()
(struct timeval { .tv_sec = 1 }) expires and returns -EAGAIN.
Consequences: (a) 'if (!ASSERT_NEQ(err, -TEST_ERRNO, "doit (allow)"))'
passes vacuously - -EAGAIN would also be returned if the kernel had
wrongly dropped the request, so the allow arm of this subtest pins
nothing; (b) the subtest silently costs a full second of wall time, and
would grow with each additional SET-style subtest added later.

Setting NLM_F_ACK in nlmsg_flags (rtnl_talk() in netlink_helpers.c
does this itself when no answer is requested) makes the kernel ack the
successful set, so the allow arm returns 0 immediately and actually
distinguishes success from 'nothing came back'.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/ethtool_lsm.c b/tools/testing/selftests/bpf/progs/ethtool_lsm.c
> new file mode 100644
> index 0000000000000..c6b21aeed6fec
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/ethtool_lsm.c
> @@ -0,0 +1,168 @@

[ ... ]

> +/*
> + * This test is used for all hooks, just checks that it is ours,
> + * and allows/denies based on the "allow" global variable
> + */
> +static int test_policy(const struct net_device *dev, __u32 cmd, __u32 sub_cmd, __u32 phy_index)
> +{
> +	__u32 pid;
> +
> +	pid = bpf_get_current_pid_tgid() >> 32;
> +	if (pid != monitored_pid)
> +		return 0;
> +
> +	if (!dev || (target_ifindex && dev->ifindex != target_ifindex))
> +		return 0;
> +
> +	if (target_cmd && cmd != target_cmd)
> +		return 0;
> +
> +	if (target_sub_cmd && sub_cmd != target_sub_cmd)
> +		return 0;
> +
> +	if (phy_index != target_phy_index)
> +		return -EDOTDOT;
> +
> +	return allow ? 0 : -EDOTDOT; /* unlikely to see this errno outside this test */
> +}

The comment on test_policy() says the helper 'just checks that it is
ours, and allows/denies based on the "allow" global variable', but the
function has a third behaviour the comment does not mention: the
phy_index test returns -EDOTDOT unconditionally, i.e. it denies
regardless of the value of allow.

That is not a cosmetic difference: it is the only place where the deny
errno is produced independently of allow, and it is precisely the
mechanism the phy_index sub-tests (cable_test_phy_index,
strset_get_phy_index_dump in prog_tests/ethtool_lsm.c) rely on - a
mismatched phy_index makes the allow phase return -EDOTDOT and
therefore fail ASSERT_NEQ(err, -TEST_ERRNO, "doit (allow)").

Note also that every other filter in the function bails out with
'return 0' (allow) when the request does not match, while this one
bails out with a denial, so the asymmetry is easy to misread as a
copy/paste slip.

A reader who trusts the comment will assume allow == true always means
'permit', and a later change to the phy_index handling can silently
turn the phy_index sub-tests into no-ops. Suggest documenting that the
phy_index comparison is an assertion that the hook argument was
propagated correctly (or gating it on target_phy_index like the other
filters and asserting the value from user space instead).

[ ... ]

> +/*
> + * CVE-2025-21701 is an example of a bug which must be mitigated under a lock,
> + * as access to dev->reg_state must be protected.
> + */
> +SEC("lsm/ethtool_netlink_doit")
> +int BPF_PROG(cve_2025_21701, const struct net_device *dev, __u32 cmd, __u32 phy_index, int ret)
> +{
> +	if (ret)
> +		return ret;
> +
> +	if (!dev)
> +		return 0;
> +
> +	return dev->reg_state >= NETREG_UNREGISTERING ?  -ENODEV : 0;
> +}

The example policy for CVE-2025-21701 installs only an
lsm/ethtool_netlink_doit program, but the hook-adding commit in this
same series (36bc9190590e4) classifies CVE-2025-21701 under 'more than
one hook required', in contrast to CVE-2024-46834 which is given both
an ioctl and a doit program a few lines below.

The upstream fix for that CVE (12e070eb6964b, 'net: avoid race between
device unregistration and ethnl ops') widened the test in
ethnl_ops_begin() to 'dev->reg_state >= NETREG_UNREGISTERING', and
ethnl_ops_begin() is reached from the dump path as well as from doit:

net/ethtool/netlink.c:ethnl_default_dump_one()
  -> ctx->ops->prepare_data()
    -> net/ethtool/channels.c:35 / net/ethtool/rss.c:158
      -> ethnl_ops_begin()

A doit-only program therefore leaves the dump entry into the same
window unpoliced, so as an 'illustration of how an actual policy might
look' it is incomplete for the CVE it names. Either add the matching
lsm/ethtool_netlink_dump program (as done for cve_2024_46834_*), or
state in the comment that only the doit half is shown and why.

Secondary nit on the same line: '?  -ENODEV' contains a doubled space
after the '?'.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33386073074
--===============6103159406767288039==--
