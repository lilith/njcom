Date: May 6 2014


# Open-source and its struggling Middle Class

**Skip to the bottom for details about [KeyHub](https://github.com/imazen/keyhub).**

I [love creating libraries](/blog/2013/war-on-waste); building high-end components that other developers can leverage. Why? Because my efforts will enable more progress than I could directly create myself.

But open-source *typically* means *free*. 

### How do open-source library developers survive? 

Here are a few common patterns I've seen in open-source projects.

1. Weekender - A project small enough that occasional weekends by one developer can keep it maintained and high-quality. 
2. Orthogonal - A project whose development was funded by a OSS-friendly business with an unrelated profit model. 
3. Bazaar - A project with immense reach and a sufficient number of contributors that progress arises from the chaos. Linux used to be an example, although it's now also an example of #4 and #2.
4. Support-based - A project sufficiently complicated to use/integrate that a large number of users will require support. Support contracts are the only viable option here; support incidents NEVER pay for themselves, let alone product development. 
5. Service bundling - Mozilla Foundation & Firefox are good examples of this; Google provides 85% of their annual income in exchange for being the default search engine. AWSSDK and Heroku Toolbelt are good examples of libraries with this model.
6. Donation-ware - Wikipedia manages to sustain itself and MediaWiki through donations, although being the 6th most popular website in the world makes this quite a bit more feasible than your average app or library.

### Weaknesses of these patterns for library development

1. Weekender projects can't have a large scope; or if they do, they need to use low-friction technology. There are lots of Weekender micro-CMSes in Ruby, while very few are maintained for .NET.
2. Orthogonal - By the nature of their orthogonality, there is little motivation for continued public maintenance after the first stable release. If properly advertised these sometimes transition to Bazaar, although more frequently they become Weekender projects or join the Unmaintained.
3. Bazaar - Libraries require absolute backwards-compatibility and API consistency. While a large volume of pull requests is helpful, the lion's share of work still falls on the official maintainer even if they're only writing unit tests and documentation. Corporate sponsorship (Orthogonal) is nearly always required, but is rare in the .NET space.
4. Support-based projects need a critical mass and a minimum quantity of enterprise eyeballs before the first dollar can arrive. There's a huge gap between Weekender and Support-based project sizes, making the transition impossible for most.
5. Service bundling works great if you're offering SaaS interface libraries. If your library works 'offline' (as most do), this isn't really an option.
6. Donation-ware needs lots of eyeballs to work. Libraries are naturally targeted to developers of a specific technology, which limits the user base too far. I've only seen a handful of libraries survive this way, and they were jQuery or Javascript libraries with extremely good advertising and millions of eyeballs.

### *New* .NET OSS projects have fewer real patterns

1. Weekender projects you fund yourself
2. Orthogonal projects your boss or client has allowed you to open-source. You'll probably make a Weekender out if it, if it's small enough, and you care enough.

#### ...but they don't scale

Neither of these options offers a profit model, neither has a path to scale. Getting them large enough to transition to Support-based can take 4-6 *years* (in my experience), and requires a *massive* financial investment.

For small projects a profit model isn't necessary. But when a project requires more than 25 hours from the maintainer per week, there's no light at the end of the tunnel. You can't offer support guarantees or contracts unless you're in control of your own time and employment.

Also - what if you WANT to focus on developing libraries full-time instead of orthogonal apps or services; what if library development is your goal?


### Middle-class software is *important*; it's how platforms evolve

Solutions to tricky problems generally require a substantial amount of code. It's an inherent trait of software; the easy problems don't need libraries very badly, while the hard problems simply can't be solved without componentization. If you're solving a end-user need, there are easier paths to profitability. If you're just solving a 'tricky' or 'painful' developer need, you're probably in the software Middle Class.

Most progress happens in the middle class; our applications are limited by the quality of the platform stack they use. As libraries harden and evolve, they continually form new layers in the application stack, and have historically moved down into the OS, windowing system, and browser.

Unfortunately, Orthogonal software is rarely great quality. Focus is rarely on the API, but rather on solving the particular itch of the business itself. Most of the great advances I've seen have come from Weekender projects which took risky, radical approaches to solving big problems. 

Open-source and .NET haven't been friends very long, and while there is definite growth from the Nordic regions and with certain applications (Umbraco, ServiceStack, Json.NET), CodePlex is overall a depressing graveyard of unmaintained, non-functional libraries that were once cared for and once worked. 

There's a strong social component to the abandonment here as well; users of .NET OSS libraries tend to forget that the developer *is doing this for free*, and browsing the Issue Tracker or Discussions page will inevitably turn up absurd scenarios. I'm sure cultural differences are also a contributing factor here; what US developers consider rude, impolite, and demanding may be socially acceptable in some countries nearer to the 17th parallel. 


## How can middle-class software survive? Here's one ugly solution:

OSS purists might stone me, but I think the following compromise could enable hundreds of failing .NET OSS projects to survive and eventually transition to a Support-based model.

### Enforced donation-ware; MIT-licensed source code with license keys

* 'Official' source code and binaries will contain license key enforcement
* Users will be legally permitted to remove the DRM and use it for free, and even branch the project and publish a DRM free version. 
* To preserve income, the official maintainer only needs to maintain better SEO ranking and better code quality than the derivative branches.
* License key enforcement should be 'light' - just watermarking or displaying an advertisement.

## How could this possibly work?

In any other language I doubt it would, however...

* The .NET space is unique among communities for its general unwillingness to ever (re)build from source code or make edits to existing projects. We can turn this 'bad side' into an advantage. 
* .NET developers aren't typically *morally* opposed to license keys, they just *wisely* avoid using closed-source software with them. If presented correctly and clearly, I don't think many .NET developers would react badly to OSS+license keys.
* .NET businesses are already conditioned to pay for components.
* NuGet distributes binaries, not source code.

But how can you do DRM in open-source?

* Like all DRM, it can be removed - just much easier
* But with 256-bit asymmetric encryption, you can eliminate keygen cracks, making it impossible to trick the stock binaries or NuGet packages.

**All you have to do is make the path of least resistance 'just buy it'.** No legal mumbo-jumbo is needed, other than your Privacy Policy if you're using a central licensing server. **Your license portal better support OpenID, offline keys, and floating domain licenses, however** &mdash; the path of least resistance needs to actually *be* less resistance than deleting 5 lines of code.

#### I think this is a bad idea if you ...

* Aren't using .NET or something very similar in culture and community.
* Already have a large user base. It's better to stretch for the support contract model than to risk alienating your entire customer base.
* Have an alternative profit model

#### This is certainly better than...

* Releasing closed-source
* Writing your own license that's incompatible with OSS licenses.


### KeyHub &mdash; lowering the barrier to entry

Licensing portals are notoriously painful &mdash; both for end-users and the maintainers. Typically, they're far out of reach for small companies, let alone individuals. 

That's where [KeyHub (Apache licensed)](http://github.com/imazen/keyhub) comes in. 

[KeyHub](http://github.com/imazen/keyhub) combines OpenId/OAuth login (no password required) with 2 great license key models: permanent offline keys (asymmetric encryption), and floating (online) keys. Keep everyone happy by letting them choose between convenience and offline support.

Our intended launch date was over a year ago, but [due to severe issues with Azure](http://www.nathanaeljones.com/blog/2014/azure), it got delayed yet again. It's now ready for alpha testing, and we'd like your help.

**To make KeyHub successful, we need to find 7+ individuals or businesses that will commit to its use and maintainance.**

If you're paying exorbiant fees for an ancient, closed-source licensing system, this is a great time to consider an exit. KeyHub is designed to support multiple vendors per application, and lends itself to a hosted scenario. Using shared infrastructure (CI, SQL, load balancing, fault tolerance, etc), we can make KeyHub both practical and reliable. 

KeyHub offers a streamlined user and vendor experience that will reduce your pain. Join us in making **keyhub.org** a reality. [Contact me](/contact), or send a pull request. 

[![KeyHub screenshot](/attachments/keyhub.png)](http://github.com/imazen/keyhub)








