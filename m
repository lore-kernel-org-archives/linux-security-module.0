From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Fri, 09 Jun 2017 06:18:27 -0400
Subject: [PATCH v2 1/1] Add Trusted Path Execution as a stackable LSM
In-Reply-To: <94ba5ebb-952b-2037-799e-07306629a6f9@nmatt.com>
References: <20170608034349.31876-1-matt@nmatt.com>
	<20170608034349.31876-2-matt@nmatt.com>
	<CAGXu5jLsrTZV_xDR_MPZdkT44P1MpbDiF3Kk2HNWBXKsdY+fzg@mail.gmail.com>
	<94ba5ebb-952b-2037-799e-07306629a6f9@nmatt.com>
Message-ID: <1497003507.21594.177.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-06-08 at 23:50 -0400, Matt Brown wrote:
> >>
> >> *? Issues:
> >>??? *? Can be bypassed by interpreted languages such as python. You can run
> >>?????? malicious code by doing: python -c 'evil code'
> >
> > What's the recommendation for people interested in using TPE but
> > having interpreters installed?
> >
> 
> If you don't need a given interpreter installed, uninstall it. While
> this is common sense system hardening it especially would make a
> difference under the TPE threat model.
> 
> I don't have a knock down answer for this. Interpreters are a hard
> problem for TPE.

You might be interested in the minor LSM named "shebang", that I
posted as a proof of concept back in January, which restricts the
python interactive prompt/interpreter, but allows the scripts
themselves to be executed.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
