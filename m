From: tytso@mit.edu (Theodore Ts'o)
Date: Tue, 28 Nov 2017 18:49:20 -0500
Subject: [kernel-hardening] Re: [PATCH v5 next 5/5] net: modules: use
	request_module_cap() to load 'netdev-%s' modules
In-Reply-To: <CAGXu5j+c8AR+3KdXKO1J180ZYZOVqK=-_MGe20g8h+dgf2RWEQ@mail.gmail.com>
References: <CA+55aFzx2eM+wVrjQEfkE-G8E9OVLcdo6vk0fDMwZNu2sh1oCQ@mail.gmail.com>
	<1100603534.56586.1511871419952@ichabod.co-bxl>
	<20171128193243.4fymnjk7fplqw62x@thunk.org>
	<CAGXu5jLtBjLSe5mbe5sYSao1o67ezkkQq_u3md9646rRfi3cCQ@mail.gmail.com>
	<CA+55aFzvaFR1skBFKwT1QPnKqxaLqCuq33FCuYz8DP7MjKkgNg@mail.gmail.com>
	<CAGXu5j+OzbUAcqVBuC8QoY-ZiA9Xw6Uf9kzfzpx9MQHQ1LtxVQ@mail.gmail.com>
	<CA+55aFz0t7cCkePJQ1w44Kw_g5nns1tYJLUOL7f-c7vriqkFig@mail.gmail.com>
	<CAGXu5j+V8+h6kdbz5Det=wsRKjt6Cm0-_n8soLCU2PZ=AvqpJQ@mail.gmail.com>
	<20171128232320.22zo324g5wvo2lce@thunk.org>
	<CAGXu5j+c8AR+3KdXKO1J180ZYZOVqK=-_MGe20g8h+dgf2RWEQ@mail.gmail.com>
Message-ID: <20171128234920.awfwicihuudw5ogx@thunk.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 28, 2017 at 03:29:01PM -0800, Kees Cook wrote:
> > So in these two cases, if the kernel was built w/o modules, and HDLC
> > and DCCP was built-in, you'd be screwed, then?
> 
> Sure, but that's not the common situation.
> 
> > Is the goal here to protect people using distro kernels which build
> > the world as modules, including dodgy pieces of kernel code that are
> > bug-ridden?
> 
> The bulk of the risk comes from distro kernels, yes. (Though "bug
> ridden" is a strong statement. There are and will be bugs, scattered
> across a wide portion of the kernel, it's just that modules tend to
> cover most of that attack surface.)

OK, but if the goal is to protect users who are running distro
kernels, then a kernel config that breaks some percentage of users is
****highly**** unlikely to be enabled by Red Hat and SuSE, right?  And
many of these users either can't (from a skills perspective) or won't
(because they lose all support from the enterprise distro's help desk)
recompile their kernel to enable an "might break 3% of all users ---
oh, well" config option.

Which argues for being extremely conservative about making something
that has an extremely low probability of breaking users, and it points
out why Geo Kozey's "who cares about breaking users; security is
IMPORTANT" argument is so wrong-headed.

If the goal is to protect distro kernels, but a sloppy approach
guarantees that distro kernels will never enable it, is it really
worth it?

	   	       	       	    	  	 - Ted

P.S.  This is where it might be useful to get some input from the Red
Hat and SuSE support teams.  How many angry user calls to their help
desk are they willing to field before they'll just turn off the kernel
config option for their kernels?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
