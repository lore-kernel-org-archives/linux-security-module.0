Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521489;
	b=jScBtF4OpV8bU88gt0I5wLPen+oDybdqFDylPkKGGey7vmkdG3qPubCpn+/vL+I1Ucdb
	 ALyQTuE556CArnBRcKMEdl926o7QLUFTWizvFuLCsVHpm7je650/7C+6nGhofxA/1jlif
	 edD2s+q1yNrVQC6tqVbtS95aELPUAPUXKXEdizaoCGd8Rwn2JUz78cEFh4LoOkMafCk+v
	 h2eyEQui+XWSQ0VlNn19Tw0tttLpyE7nLZPHDX4hX2cQp6sGhw4UUxlEhFzOseU2+qHBW
	 5ux3hdvwMDUEjjQQDhsJQB3uyXiizQH5ESyaxeFmiDvsMRP1I+90AcpClfCNScSBAuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521489;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=Pr5tsmnntCf16xoQZruQvjUzk9vMB//UroElAOAsHX4=;
	b=UC2eLqmS0gGM1i3N+dC/G/8RO5s1rU1769f1oiGo0t4I7Jrh/7/EevmUEi+uWnzfdiRO
	 /K/sPQQtQuIyRQR9UrDHdIDK45jo1RwE3taLx3dZjlLh41U19piXWrz7sn1ugktzLXQnS
	 FjYbDKJHySRDikIiR0WS28Dk9i8+LTSWdyqcdnEYMwMrDjOOSiZp/AVLP2K8DfiLSsTvI
	 4S6H/27Kz8rFZ8m3cu/LZTwVC5cRWKD5d/u5Gm/pOjUxGPzmFbbzPaA03St9dYn939eIP
	 Z2cCC92xi2pWlXWsdjFCMXqYzQlcSw+D+zgu9MM8qylWV2FTUr+wTqOysUPQU4fBDgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=yMdKCsMo;
	arc=none smtp.remote-ip=83.166.143.173
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AED5606A333
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 18:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AED5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=yMdKCsMo
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j8Lkw5qmyzQnb;
	Tue, 20 Oct 2026 20:38:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1792521480;
	bh=Pr5tsmnntCf16xoQZruQvjUzk9vMB//UroElAOAsHX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yMdKCsMolUavEVmgMhSTA49ormN3OEV/fDdxYmqsA7HkJHcEwxL/HPA/yAlAw+0iF
	 dmtOdiH0jvq4OUTMreoubhxD7uszI5MrBlsbriJHkXED08zJUO8HpGLFBjDQkh5KSX
	 INXyii7ZadMPi2U+U2FE2AjiSBHRz0+UMrO9R1HA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4j8Lkt4K95zMPV;
	Tue, 20 Oct 2026 20:37:58 +0200 (CEST)
Date: Tue, 20 Oct 2026 20:37:57 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH bpf-next v1 00/11] fs: unified VFS ancestor walk for
 Landlock and BPF
Message-ID: <20261020.eiP2Kohshahj@digikod.net>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
 <DM6PICFFAU5Z.14KOZT5YJO7MA@gmail.com>
 <atdw4wVVarvwgRH0@zenbox>
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
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <atdw4wVVarvwgRH0@zenbox>
X-Infomaniak-Routing: alpha

On Tue, Oct 20, 2026 at 10:05:54AM -0400, Justin Suess wrote:
> On Sat, Oct 17, 2026 at 01:02:40AM +0000, Alexei Starovoitov wrote:
> > On Tue, Oct 13, 2026 at 12:47 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > > The structure is unchanged from the RFC [2]: a stepwise engine private
> > > to namei.c, a callback front-end for in-kernel callers (Landlock
> > > is converted, fixing the follow_up() race Al reported, hence the
> > > Fixes: tag on patch 3), and open-coded BPF iterators over the engine in
> > > referenced and rcu flavors, with bpf_path_ancestors_legitimize()
> > > escalating from the latter to the former mid-walk.  Patch 1 is carried
> > > from Song's series.  See the RFC cover for the full background and API
> > > listing.
> > 
> > Song's series stopped at
> > "It is a conceptual dead-end to expose these two modes via separate APIs
> > and leak this implementation detail into non-core code. It will not
> > happen as far as I'm concerned."
> > VFS_WALK_RCU, -ECHILD to the caller, two bpf iterators and the
> > legitimize kfunc are that leak.
> Following up on this, plan is I'll submit v2 of the verifier fixes
> series and get that finished first.
> 
> Then after that I'll do a redesign around a single iterator
> implementation that decides the walk type and abstracts away the details.
> It will be KF_RCU_PROTECTED and callers will need to break out of the
> loop to do sleepable work. They'll be able to acquire the path
> references with a kfunc to take them out of the loop.
> 
> That drops the __uninit iterator changes and the legitimize kfunc as
> well.
> 
> > Landlock still passes flags == 0, so nothing in the kernel walks in
> > rcu mode.
> Mickaël would you be interested in the hybrid walk conversion as part
> of this series? Or prefer sleepable walk be retained for now and
> converted later?

I would prefer a standalone series for VFS and Landlock that also
include (with dedicated patches) the RCU optimization proposed by
Tingmao.  That would prove that it works end-to-end with the RCU
optimization, and that would be easier to review and merge.  Then a
series dedicated to BPF could leverage this work.

> 
> Justin
> > Patches 1-3 fix a real race and don't need bpf.
> > Send them to Christian, Al and Mickael on their own.
> > 
> > > Verifier fixes propagating the RCU-ness to trusted fields can be done,
> > > but it's best as a separate series where the idea can be examined more
> > > closely.  Then marking the dentry as trusted will allow you to use the
> > > dentry xattr kfuncs.  Nothing in this series strictly depends on having
> > > a trusted dentry, nor will marking it trusted require changes in this
> > > API.  See my follow up [4].
> > 
> > Then what can a prog do with a position?
> > pos->dentry is untrusted now.
> > Marking it trusted will require changes.
> > d = pos->dentry is not linked to pos. It will stay trusted after
> > bpf_path_put(pos).
> > pos of the rcu iterator points into bpf stack.
> > MEM_RCU propagation fixes neither.
> > What next() should return depends on how the verifier tracks it.
> > Let's do the verifier part first.
> > 
> > pw-bot: cr
> 
