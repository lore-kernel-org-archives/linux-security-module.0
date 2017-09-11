From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 10 Sep 2017 23:38:34 -0700
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <1505052162.3224.64.camel@linux.vnet.ibm.com>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
	<alpine.LRH.2.21.1709081448090.7880@namei.org>
	<20170908070943.GA26549@infradead.org>
	<CA+55aFwMgUJSMQ96XdKnTbn8UsxzHTb8tZQdH40nxDeF7fWObw@mail.gmail.com>
	<20170910081047.GA19533@infradead.org>
	<1505052162.3224.64.camel@linux.vnet.ibm.com>
Message-ID: <20170911063834.GB10489@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Sep 10, 2017 at 10:02:42AM -0400, Mimi Zohar wrote:
> We need to differentiate between policies and x509 certificates. ?In
> the policy case, they need to be signed and appraised, while in the
> x509 certificate case, the certificate itself is signed so the file
> doesn't need to be signed or verified.

How about you take this sketch over - I don't know much about the
integrity code, and it seems like you actually wrote
kernel_read_file_from_path as well - so you're at least 3 times as
qualified as I am in this area..
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
