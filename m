Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.14.7.126
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347291;
	b=KrN0GfP8OJoPlBhU2mua4AxaNAHntZMeRHUJKOSCeAKqa1VlpH1WH4RK5RZnad5REWm+
	 jBmdtyVD/K6z9tdpFei+RWnKainpPVYTgHREzhb6RDqRHgbpPuCtYEFn1dokyEOTOy0jG
	 fKq/g+52Hod7g80kVOeQoN86Jj8ewxKsxwvdLos6dZHqjtXxtEpsvIFe5wN0h3B9wg3G8
	 IX6OjuM3fJE+HZQ8h4RAzve/3ryowgOiDWztLsnuzLBao8s2CpPb6d97d+frPsKVdv/Tm
	 5e42QzfiuOiEwm0HxRfFQX3Qhu395ghKKJPOcY51Xqf6aJpd7oAv+hhKdpAh1UqRUcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347291;
	h=DMARC-Filter:Received:Received:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:From:Message-ID:Subject:To:
	 In-Reply-To:References:X-Virus-Scanned;
	bh=kyCcKMZDJ0cRp+N7aPx7olATKtpISCOT5VPJWBSatFI=;
	b=Za3uxXPsTqG7h+LbNdxWuQrvdCDnlgR7zkYmAbdj8Kng1DnbwzOnSYRVCBq/c9dCJv4p
	 pwSGzeckADKqvC1Di0FZkaMSUxJM7zrbSU4hM7saORkLM+keGcpErS1SDVhQI/KSEmXJK
	 bNZNMh7OfjHJBcB7jR8+zNr45kuXvPoUDM/HEgKSQRi/grmyuTWygwRc26do6JIDErh82
	 TJTVhao6MAYG4/TV9dGpCQS/Ghsmi0sVQR31Sdgk3nDgZvXkSbq8l3OxeEgJvDEnKe6g1
	 1zwpMGSriM87jqQoP4zfflUpia2t6tN8VK5qJs9Q23HBL0e6jbvd7Ps5JI9m504Bjmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yuhu.biz;
	spf=pass smtp.mailfrom=yuhu.biz;
	arc=none smtp.remote-ip=85.14.7.126
Received: from BlackPearl.yuhu.biz (mail.bgservers.net [85.14.7.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E661B606A32D
	for <linux-security-module@vger.kernel.org>; Tue, 10 Nov 2026 21:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E661B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yuhu.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yuhu.biz
Received: from BlackPearl.yuhu.biz (localhost [127.0.0.1])
	by BlackPearl.yuhu.biz (Postfix) with ESMTP id DBB4E1460471;
	Tue, 10 Nov 2026 23:47:58 +0200 (EET)
Received: from n.1h.cx (n.1h.cx [185.225.236.3])
	(using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.yuhu.biz (Postfix) with ESMTPSA id 36E47146046F;
	Tue, 10 Nov 2026 23:47:58 +0200 (EET)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 10 Nov 2026 21:10:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.14.0
From: "Marian Marinov" <hackman@yuhu.biz>
Message-ID: <41d34b3d360842498a689720f71a85e2@yuhu.biz>
Subject: Re: [Case Study] CVE-2024-0582: Why We Need a Standard for CVE
 Emergency Mitigation
To: "Nakashima Seiichi" <s-nakashima@kjb.biglobe.ne.jp>,
 kernel-hardening@lists.openwall.com, linux-security-module@vger.kernel.org
In-Reply-To: <1d9ab7140a015e94829e2356a4c6c9e18d92b864.camel@kjb.biglobe.ne.jp>
References: <1d9ab7140a015e94829e2356a4c6c9e18d92b864.camel@kjb.biglobe.ne.jp>
X-Virus-Scanned: ClamAV using ClamSMTP

I admire your push toward this and I like where you are going with this.=
=0A=0ASo here is my addition to your point. =0A=0AA system, even a defini=
tion standard, has to take into account dependencies. =0AYou can not bloc=
k certain parts of the kernel. For example, you can't block accepting IPv=
4 packets, without this disconnecting your system from the internet or si=
milarly, you can't block a generic bio operation without essentially bloc=
king all I/O on your system. =0AThese are the basic problems that you hav=
e to deal with. The more subtile problems come after that...=0AWhat would=
 happen if you block or simply return from certain kernel functions? The =
code works by expecting certain paths to be taken. The moment you cut off=
 some of these paths, you might open larger holes in the system or open i=
t to instability resulting in crashes. =0A=0AI believe that the current t=
ools we have in our hands and especially the livepatching mechanism are t=
he way we should be going, hence why I started my livepatch repo this yea=
r. But such effort must come with the understanding of the kernel and its=
 sub-systems. =0AThere is no kernel developer that knows all systems and =
their dependencies. Which makes the work required for implementing a KAF =
notice(not a patch, just a message of what has to be blocked and how) har=
der than most livepatches you might need to build. =0A=0AFor many of thes=
e problems an ftrace or eBPF program would be a sufficient temporary meas=
ure, until you have time to schedule a maintenance reboot and upgrade. =
=0A=0AMarian=0A=0ANovember 10, 2026 4:28 PM, "Nakashima Seiichi" <s-nakas=
hima@kjb.biglobe.ne.jp> wrote:=0A=0A> Hi all,=0A> =0A> "The question is n=
ot 'can we block this?' The technology already can.=0A> The question is '=
how do we make blocking this repeatable, auditable,=0A> and distributable=
 across all Linux systems?' That is what a standard=0A> addresses."=0A> =
=0A> We suspect many of you already recognize the facts presented in this=
=0A> case study. The patch gap is not a new problem. Tetragon, BPF LSM,=
=0A> and seccomp-bpf are not new technologies. What we are attempting to=
=0A> do here is not to discover something unknown, but to articulate=0A> =
something that has remained implicit: the gap between "technically=0A> po=
ssible" and "operationally scalable" is a standards problem, not a=0A> te=
chnology problem.=0A> =0A> Following up on the kaf (Kernel API Firewall) =
standard specification=0A> RFC shared previously, we would like to share =
a concrete case study=0A> that validates this premise.=0A> =0A> The attac=
hed case study examines CVE-2024-0582, an io_uring=0A> use-after-free vul=
nerability that had a 2.5-month patch gap between=0A> upstream fix (Decem=
ber 2023) and Ubuntu deployment (February 2024).=0A> During this gap, Exo=
dus Intelligence successfully demonstrated a=0A> data-only exploit achiev=
ing root from an unprivileged user.=0A> =0A> Importantly, this case study=
 does NOT claim that new kernel technology=0A> is needed. Tetragon, BPF L=
SM, and seccomp-bpf are all capable of=0A> blocking the vulnerable code p=
ath today. What does not exist is a=0A> standardized way to package, dist=
ribute, and lifecycle-manage=0A> CVE-specific policies across distributio=
ns and organizations.=0A> =0A> The case study demonstrates the gap betwee=
n "technically possible"=0A> and "operationally scalable." With a standar=
dized framework, the=0A> mitigation could have started on CVE publication=
 day instead of=0A> waiting ~2.5 months for the distro patch.=0A> =0A> Th=
e full analysis is in the attached HTML document. It includes:=0A> - Deta=
iled timeline of the patch gap=0A> - Technical analysis of the exploit co=
de path=0A> - Policy definitions using existing technology in a standardi=
zed format=0A> - Operational timeline showing how a standard would have w=
orked=0A> - Quantitative comparison: ad-hoc vs. standardized approach=0A>=
 =0A> This case study is intended to demonstrate that the question is not=
=0A> "can we block this?" - the technology already can. The question is=
=0A> "how do we make blocking this repeatable, auditable, and distributab=
le=0A> across all Linux systems?" That is what a standard addresses.=0A> =
=0A> The kaf standard specification RFC is available at:=0A> (Previously =
shared on kernel-hardening and linux-security-module)=0A> =0A> Feedback, =
corrections, and discussion are welcome.=0A> =0A> Best regards,=0A> -- ka=
f Working Group=0A> =0A> Acknowledgments: The structure, analysis, and dr=
afting of this case=0A> study were developed with assistance from Namazu,=
 an AI assistant at=0A> Sakana AI. The technical conclusions and policy d=
irection remain the=0A> responsibility of the kaf Working Group.=0A> =0A>=
 Nakashima Seiichi=0A> Sakana AI's Namazu
