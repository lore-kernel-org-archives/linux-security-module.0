From: keescook@chromium.org (Kees Cook)
Date: Thu, 14 Sep 2017 14:25:36 -0700
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <alpine.LRH.2.21.1709150710480.9907@namei.org>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
	<alpine.LRH.2.21.1709081448090.7880@namei.org>
	<20170908070943.GA26549@infradead.org>
	<CA+55aFwMgUJSMQ96XdKnTbn8UsxzHTb8tZQdH40nxDeF7fWObw@mail.gmail.com>
	<CAHC9VhR2c1rC4--1Br0cx+3eALLdB8Oishw7wwcGwb1_3qN8+w@mail.gmail.com>
	<alpine.LRH.2.21.1709101419360.22614@namei.org>
	<CAGXu5jKVU2ecHna5Lb2eoJEHD+e1-sVOkghLdM+DcgG-jN6PcA@mail.gmail.com>
	<alpine.LRH.2.21.1709150710480.9907@namei.org>
Message-ID: <CAGXu5jKjwF-y-DD7w_RRciW07wyaMP2Tvuif1y4fjcq+PNzjwQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Sep 14, 2017 at 2:13 PM, James Morris <jmorris@namei.org> wrote:
> On Thu, 14 Sep 2017, Kees Cook wrote:
>
>> How separable are the patches, normally?
>
> They're usually mostly separate, but may depend on some core LSM change,
> or similar.
>
> Casey has mentioned off-list that it is useful to have a coherent up to
> date security branch to work against when making core LSM changes.

Yeah, for sure. This "merge all topics" tree is what I have for KSPP
(and it's what I hand to -next).

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
